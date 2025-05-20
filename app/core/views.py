from django.shortcuts import render
from service.models import Service, ServiceCategory

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