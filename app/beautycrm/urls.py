from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views
from django.urls import path, include

from core.views import index, about
from profile.forms import LoginForm

urlpatterns = [
    path('', index, name='index'),
    path('dashboard/services/', include('service.urls')),
    path('dashboard/appointment/', include('appointment.urls')),
    path('dashboard/payment/', include('payment.urls')),
    path('dashboard/', include('profile.urls')),
    path('dashboard/', include('dashboard.urls')),
    path('about/', about, name='about'),
    path('log-in/', views.LoginView.as_view(template_name='account/login.html', authentication_form=LoginForm), name='login'),
    path('log-out/', views.LogoutView.as_view(), name='logout'),
    path('admin/', admin.site.urls),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# +static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
