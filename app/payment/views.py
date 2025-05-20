from django.utils.timezone import now
from django.db.models import Sum, Q
from django.views.generic import TemplateView
from datetime import datetime

from django.shortcuts import render
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView
from django.urls import reverse_lazy

from appointment.models import Appointment
from profile.models import WorkerProfile
from .models import Payment

# Create your views here.
class PaymentListView(ListView):
    model = Payment
    template_name = 'payment/payment_list.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        today = now()
        month_start = today.replace(day=1)

        workers = WorkerProfile.objects.filter(is_active=True)
        salaries = []

        for worker in workers:
            all_appointments = Appointment.objects.filter(worker=worker)
            completed_appointments = all_appointments.filter(status='completed')
            canceled_appointments = all_appointments.filter(status='canceled')
            confirmed_appointments = all_appointments.filter(status='confirmed')
            
            # Подсчёт завершённых и отменённых записей
            completed_count = completed_appointments.count()
            canceled_count = canceled_appointments.count()
            confirmed_count = confirmed_appointments.count()
            total_considered = completed_count + canceled_count

            # Рейтинг
            if total_considered > 0:
                rating = round((completed_count / total_considered) * 100, 2)
            else:
                rating = 0
            
            appointments = Appointment.objects.filter(
                worker=worker,
                status='completed'
            )

            # Выплаченный заработок
            total_earned = appointments.filter(
                start_time__lte=month_start
            ).aggregate(
                total=Sum('service__price')
            )['total'] or 0
            
            # Заработок за текущий месяц
            monthly_earned = appointments.filter(
                start_time__gte=month_start
            ).aggregate(
                total=Sum('service__price')
            )['total'] or 0

            salaries.append({
                'worker': worker,
                'total_earned': total_earned,
                'monthly_earned': monthly_earned,
                'rating': rating,
                'completed': completed_count,
                'canceled': canceled_count,
                'confirmed': confirmed_count,
            })
        context['salaries'] = salaries
        return context

class PaymentCreateView(CreateView):
    model = Payment
    template_name = 'payment/payment_form.html'
    success_url = reverse_lazy('payment:list')

class PaymentDetailView(DetailView):
    model = Payment
    template_name = 'payment/payment_detail.html'

class PaymentUpdateView(UpdateView):
    model = Payment
    template_name = 'payment/payment_form.html'
    fields = '__all__'
    success_url = reverse_lazy('payment:list')

class PaymentDeleteView(DeleteView):
    model = Payment
    template_name = 'payment/payment_confirm_delete.html'
    success_url = reverse_lazy('payment:list')