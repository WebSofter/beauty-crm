from django.shortcuts import render
from django.urls import reverse_lazy
from unidecode import unidecode
from utils.messager import send_custom_email
from core.forms import OrderForm, OrderNoAuthForm
from appointment.models import Appointment
from service.models import Service, ServiceCategory
from django.views.generic.edit import FormView
from profile.models import ClientProfile
from django.contrib.auth.models import User

def index(request):
    # return render(request, 'core/index.html')
    # Получаем все активные категории
    categories = ServiceCategory.objects.filter(is_active=True)
    
    # Контекст с категориями и их услугами
    context = {
        'service_categories': categories,
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
    success_url = reverse_lazy('profile:myaccount')

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
        # self.object = form.save(commit=False)
        # self.object.created_by = self.request.user
        # self.object.save()
        # Получаем данные из формы
        # client_data = {
        #     'name': form.cleaned_data.get('name'),
        #     'email': form.cleaned_data.get('email'),
        #     'phone': form.cleaned_data.get('phone'),
        # }
        # # Создаем или получаем профиль клиента
        # client_profile, created = ClientProfile.objects.get_or_create(
        #     user__firstname=client_data['name'],
        #     user__username=unidecode(client_data['name']),
        #     user__email=client_data['email'],
        #     user__password='secret1989',
        #     defaults={
        #         'phone': client_data['phone'],
        #     }
        # )
        # # Если профиль уже существовал, обновим телефон
        # if not created:
        #     client_profile.phone = client_data['phone']
        #     client_profile.save()
        
        # 1. Получаем профиль и связанного пользователя
        # profile = form.save(commit=False)
        # user = profile.user
        user = self.request.user if self.request.user.is_authenticated else None
        # 2. Обновляем данные пользователя из очищенных данных формы
        if not user:
            user = User.objects.create_user(
                username=unidecode(form.cleaned_data['username']),
                password='secret1989',
                first_name=form.cleaned_data['name'],
                # last_name=form.cleaned_data['last_name'],
                email=form.cleaned_data['email'],
            )
        # Создаем профиль
        client_profile, created = ClientProfile.objects.get_or_create(
            user=user,
            defaults={
                'phone': form.cleaned_data.get('phone'),
            }
        )
        # Создаем запись на прием
        appointment = Appointment.objects.create(
            client=client_profile,
            service=form.cleaned_data.get('service'),
            worker=form.cleaned_data.get('worker'),
            start_time=form.cleaned_data.get('start_time'),
            status='pending',
            notes=form.cleaned_data.get('notes', '')
        )
        return super().form_valid(form)