from django.contrib.auth.decorators import login_required
from django.shortcuts import render

from service.models import Service

@login_required
def dashboard(request):
    service = Service.objects.order_by('-created_at')[0:5]

    return render(request, 'dashboard/dashboard.html', {
        'service': service,
    })