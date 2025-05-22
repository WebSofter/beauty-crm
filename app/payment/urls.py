from django.urls import path

from . import views

app_name = 'payment'

urlpatterns = [
    # Выплаты
    path('', views.PaymentListView.as_view(), name='list'),
    path('create/', views.PaymentCreateView.as_view(), name='create'),
    path('<int:pk>/update/', views.PaymentUpdateView.as_view(), name='update'),
]