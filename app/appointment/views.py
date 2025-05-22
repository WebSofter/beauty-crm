from django.shortcuts import render

# Create your views here.
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import redirect, get_object_or_404
from django.urls import reverse_lazy
from django.views import View
from django.views.generic import ListView, DetailView, DeleteView, UpdateView, CreateView

from utils.messager import send_custom_email

from .forms import AppointmentForm, ReviewForm
from .models import Appointment, Review

class AppointmentListView(LoginRequiredMixin, ListView):
    model = Appointment
    
    def get_queryset(self):
        queryset = super(AppointmentListView, self).get_queryset()
        return queryset.all()

class AppointmentCreateView(LoginRequiredMixin, CreateView):
    model = Appointment
    form_class = AppointmentForm
    success_url = reverse_lazy('appointment:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        context['form'] = AppointmentForm()
        context['title'] = 'Добавить запись'

        return context

    def form_valid(self, form):
        self.object = form.save(commit=False)
        self.object.created_by = self.request.user
        self.object.save()
        
        return redirect(self.get_success_url())
class AppointmentDetailView(LoginRequiredMixin, DetailView):
    model = Appointment
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['form'] = AppointmentForm()

        return context

    def get_queryset(self):
        queryset = super(AppointmentDetailView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))
    
class AppointmentDeleteView(LoginRequiredMixin, View):
    def post(self, request, pk):
        category = get_object_or_404(Appointment, pk=pk)
        # можно добавить проверку доступа
        category.delete()
        return redirect('appointment:list')

    def get(self, request, *args, **kwargs):
        # запретить или сделать редирект
        return redirect('appointment:list')

class AppointmentUpdateView(LoginRequiredMixin, UpdateView):
    model = Appointment
    form_class = AppointmentForm
    success_url = reverse_lazy('appointment:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Изменить запись'

        return context

    def form_valid(self, form):
        # Отправляем email после успешной валидации формы
        subject = 'Изменения в записи'
        message = f'''
        {form.instance.client}
        {form.instance.worker} 
        Статус: {form.instance.status} 
        Комментарий: {form.instance.notes} 
        Дата и время: {form.instance.start_time}
        '''
        send_custom_email(
            subject=subject,
            message=message,
            recipient_list=[form.instance.client.user.email]
        )
        
        # ВАЖНО: вызываем родительский метод form_valid
        return super().form_valid(form)

    def get_queryset(self):
        # Этот метод должен быть отдельным для фильтрации объектов
        queryset = super().get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))

    # def form_valid(self, form):

    #     subject = 'Изменения в записи'
    #     message = f'''
    #     Клиент: {form.instance.client}
    #     Мастер: {form.instance.worker} 
    #     Статус: {form.instance.status} 
    #     Дата и время: {form.instance.start_time}
    #     '''
    #     send_custom_email(
    #         subject=subject,
    #         message=message,
    #         recipient_list=[form.instance.client.user.email]
    #     )
        
    #     queryset = super(AppointmentUpdateView, self).get_queryset()
    #     return queryset.filter(pk=self.kwargs.get('pk'))





class AppointmentReviewView(LoginRequiredMixin, CreateView):
    model = Review  # Создаем Review, а не Appointment
    form_class = ReviewForm
    template_name = 'appointment/review_form.html'
    success_url = reverse_lazy('dashboard:index')

    def dispatch(self, request, *args, **kwargs):
        # Проверяем, что appointment существует
        self.appointment = get_object_or_404(Appointment, pk=self.kwargs['pk'])
        
        # Убедимся, что пользователь — клиент
        if not hasattr(request.user, 'clientprofile'):
            return redirect('dashboard:access_denied')
        
        # Проверяем, что это клиент этой записи
        if self.appointment.client != request.user.clientprofile:
            return redirect('dashboard:access_denied')
        
        return super().dispatch(request, *args, **kwargs)

    def get_initial(self):
        initial = super().get_initial()
        initial['client'] = self.appointment.client.pk  # Передаем ID
        initial['worker'] = self.appointment.worker.pk  # Передаем ID
        initial['appointment'] = self.appointment.pk    # Передаем ID
        return initial

    def form_valid(self, form):
        form.instance.client = self.appointment.client
        form.instance.worker = self.appointment.worker
        form.instance.appointment = self.appointment
        return super().form_valid(form)