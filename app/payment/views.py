from django.utils.timezone import now
from django.db.models import Sum, Q
from django.views.generic import TemplateView
from datetime import datetime

from django.shortcuts import render
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView
from django.urls import reverse_lazy

from payment.forms import PaymentForm, SalaryForm
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
            # total_earned = appointments.filter(
            #     start_time__lte=month_start
            # ).aggregate(
            #     total=Sum('service__price')
            # )['total'] or 0
            monthly_payout = Payment.objects.filter(
                worker=worker,
                payment_date__gte=month_start
            ).aggregate(
                total=Sum('amount')
            )['total'] or 0             
            
            # Заработок за текущий месяц
            monthly_earned = appointments.filter(
                start_time__gte=month_start
            ).aggregate(
                total=Sum('service__price')
            )['total'] or 0

            salaries.append({
                'worker': worker,
                'monthly_payout': monthly_payout,
                'monthly_earned': monthly_earned,
                'rating': rating,
                'completed': completed_count,
                'canceled': canceled_count,
                'confirmed': confirmed_count,
            })
        context['salaries'] = salaries
        context['payments'] = Payment.objects.all()
        return context
class PaymentUpdateView(UpdateView):
    model = WorkerProfile
    form_class = SalaryForm
    template_name = 'payment/payment_form.html'
    success_url = reverse_lazy('payment:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        worker = self.get_object()
        print(worker)
        # context['payment'] = payment
        # context['worker'] = payment.worker
        return context

    def form_valid(self, form):
        worker = form.save(commit=False)
        worker.save()
        return super().form_valid(form)

# class PaymentCreateView(CreateView):
#     model = Payment
#     form_class = PaymentForm
#     template_name = 'payment/payment_form.html'
#     success_url = reverse_lazy('payment:list')

#     def get_initial(self):
#         initial = super().get_initial()
#         worker_id = self.request.GET.get('worker')
#         if worker_id:
#             initial['worker'] = worker_id
#         return initial

#     def form_valid(self, form):
#         form.instance.payment_date = form.instance.payment_date or now()
#         form.instance.worker = WorkerProfile.objects.get(id=form.instance.worker.id)
#         return super().form_valid(form)

class PaymentCreateView(CreateView):
    model = Payment
    form_class = PaymentForm
    template_name = 'payment/payment_form.html'
    success_url = reverse_lazy('payment:list')

    def get_initial(self):
        initial = super().get_initial()
        worker_id = self.request.GET.get('worker')
        if worker_id:
            initial['worker'] = worker_id
        return initial

    def form_valid(self, form):
        if not form.instance.payment_date:
            form.instance.payment_date = now()
        return super().form_valid(form)