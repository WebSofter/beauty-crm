from django.contrib.auth.decorators import login_required
from django.shortcuts import render

from utils.profile_helper import get_profile
from payment.models import Payment
from profile.models import ClientProfile
from service.models import Service
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView
from django.db.models import Count, Sum
from appointment.models import Appointment
from profile.models import WorkerProfile

from django.utils.timezone import now

@login_required
def dashboard(request):
    service = Service.objects.order_by('-created_at')[0:5]
    cleints = ClientProfile.objects.order_by('-created_at')
    return render(request, 'dashboard/dashboard.html', {
        'service': service,
        'cleints': cleints,
    })
    
    
class DashboardView(LoginRequiredMixin, TemplateView):
    template_name = 'dashboard/dashboard.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # Записи
        appointments = []
        profile_type = None
        
        if self.request.user.is_superuser:
            appointments = Appointment.objects.all()
        else:
            profile, profile_type = get_profile(self.request.user)
            if profile_type == 'client':
                appointments = Appointment.objects.filter(client=profile).all()
            else:
                appointments = Appointment.objects.filter(worker=profile).all()
                # выплаченная ЗП
                today = now()
                month_start = today.replace(day=1)
                monthly_payout = Payment.objects.filter(
                    worker=profile,
                    payment_date__gte=month_start
                ).aggregate(
                    total=Sum('amount')
                )['total'] or 0
                context['monthly_payout'] = monthly_payout
                
            # client_profile = ClientProfile.objects.get(user=self.request.user)
            # appointments = Appointment.objects.filter(client=client_profile).all() # ClientProfile.objects.get(user=self.request.user).appointments.all()

        # for appointment in appointments:
        #     print("appointment raw data:", appointment.id)
        #     print("client:", appointment.client)
        #     print("worker:", appointment.worker)
        #     print("service:", appointment.service)
        #     print("start_time:", appointment.start_time)
        #     print("status:", appointment.status)
        
        total_income = 0
        total_appointments = 0

        for appointment in appointments:
            if appointment.service and appointment.service.price:
                total_income += appointment.service.price
                total_appointments += 1
            
        context['profile_type'] = profile_type
        context['total_income'] = total_income
        context['total_appointments'] = total_appointments
        context['appointments'] = appointments
        
        # Клиенты
        context['service'] = Service.objects.order_by('-created_at')[:5]
        context['clients'] = ClientProfile.objects.order_by('-created_at')
        
        # Статистика
        today = now()
        month_start = today.replace(day=1)
        # Get search and sort parameters from request
        keyword = self.request.GET.get('keyword', '')
        sort_field = self.request.GET.get('field', 'id')
        sort_direction = self.request.GET.get('sort', 'asc')

        # Build queryset with search filter
        workers = WorkerProfile.objects.filter(is_active=True)
        if keyword:
            workers = workers.filter(user__first_name__icontains=keyword) | workers.filter(user__last_name__icontains=keyword)
        # Apply sorting
        if sort_field:
            if sort_field in ['id']:
                sort_param = '-' + sort_field if sort_direction == 'desc' else sort_field
                workers = workers.order_by(sort_param)
            else:
            # Apply sorting for worker and position fields
                if sort_field in ['worker', 'position']:
                    if sort_field == 'worker':
                        sort_param = '-user__first_name' if sort_direction == 'desc' else 'user__first_name'
                    elif sort_field == 'position': 
                        sort_param = '-position__name' if sort_direction == 'desc' else 'position__name'
                    else:
                        sort_param = '-' + sort_field if sort_direction == 'desc' else sort_field
            workers = workers.order_by(sort_param)
                    
                 
        statistics = []
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

            statistics.append({
                'worker': worker,
                'monthly_payout': monthly_payout,
                'monthly_earned': monthly_earned,
                'rating': rating,
                'completed': completed_count,
                'canceled': canceled_count,
                'confirmed': confirmed_count,
            })
        context['statistics'] = statistics
            
        # print(f"Всего выплат: {stats['total_payments']}")
        # print(f"Общая сумма выплат: {stats['total_amount']} ₽")
        return context


