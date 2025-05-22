from django.shortcuts import render
from django.urls import reverse_lazy
from unidecode import unidecode
from utils.messager import send_custom_email
from core.forms import OrderForm, OrderNoAuthForm
from appointment.models import Appointment, Review
from service.models import Service, ServiceCategory
from django.views.generic.edit import FormView
from profile.models import ClientProfile
from django.contrib.auth.models import User
from django.utils.crypto import get_random_string

def index(request):
    # Получаем все активные категории
    categories = ServiceCategory.objects.filter(is_active=True)
    
    # Получаем список отзывов
    reviews = Review.objects.all()
    
    # Контекст с категориями и их услугами
    context = {
        'service_categories': categories,
        'reviews': reviews,
    }
        
    return render(request, 'core/index.html', context)

def about(request):
    return render(request, 'core/about.html')

def service(request):
    # return render(request, 'core/index.html')
    # Получаем все активные категории
    categories = ServiceCategory.objects.filter(is_active=True)
    
    # Контекст с категориями и их услугами
    context = {
        'service_categories': categories,
    }
        
    return render(request, 'core/service.html', context)


class OrderView(FormView):
    # model = Appointment
    form_class = OrderNoAuthForm
    template_name = 'core/order.html'
    success_url = reverse_lazy('dashboard:index')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        service_id = self.request.GET.get('service')
        service = Service.objects.filter(id=service_id).first()
        context['service'] = service
        # send_custom_email(
        #     subject='Запись подтверждена',
        #     message='Ваша запись в салон успешно подтверждена.',
        #     recipient_list=['mail.websofter@gmail.com']
        # )
        return context

    def get_form_kwargs(self):
        kwargs = super().get_form_kwargs()
        service_id = self.request.GET.get('service')
        if service_id:
            kwargs['initial'] = kwargs.get('initial', {})
            kwargs['initial']['service'] = service_id
        return kwargs

    def form_valid(self, form):
        user = self.request.user if self.request.user.is_authenticated else None
        # 2. Обновляем данные пользователя из очищенных данных формы
        if not user:
            username = unidecode(form.cleaned_data['name'].lower())
            password = get_random_string(length=6)
            email = form.cleaned_data['email']
            user = User.objects.create_user(
                username=username,
                password=password,
                first_name=form.cleaned_data['name'],
                # last_name=form.cleaned_data['last_name'],
                email=email,
            )
            if email:
                send_custom_email(
                    subject='Создана учетная запись',
                    message=f'Ваша аккаунт успешно создан: логин: {username}, пароль: {password}',
                    recipient_list=[email]
                )
        # Создаем профиль
        client_profile, created = ClientProfile.objects.get_or_create(
            user=user,
            defaults={
                'phone': form.cleaned_data.get('phone'),
            }
        )
        # Создаем запись на прием
        start_time = form.cleaned_data.get('start_time')
        worker = form.cleaned_data.get('worker')
        service = form.cleaned_data.get('service')
        appointment = Appointment.objects.create(
            client=client_profile,
            service=service,
            worker=worker,
            start_time=start_time,
            status='pending',
            notes=form.cleaned_data.get('notes', '')
        )
        if user.email:
            send_custom_email(
                subject='Вы записаны в салон красоты',
                message=f'Вы успешно записаны на процедулу {service.name}. Время: {start_time}',
                recipient_list=[user.email]
            )
        if worker.user.email:
            send_custom_email(
                subject='К вам записался клиент',
                message=f'Клиент записан на процедуру {service.name}. Время: {start_time}',
                recipient_list=[worker.user.email]
            )
        return super().form_valid(form)