from django.urls import path

from . import views

app_name = 'appointment'

urlpatterns = [
    # Записи
    path('', views.AppointmentListView.as_view(), name='list'),
    path('create/', views.AppointmentCreateView.as_view(), name='create'),
    path('<int:pk>/', views.AppointmentDetailView.as_view(), name='detail'),
    path('<int:pk>/update/', views.AppointmentUpdateView.as_view(), name='update'),
    path('<int:pk>/delete/', views.AppointmentDeleteView.as_view(), name='delete'),
    path('<int:pk>/review', views.AppointmentReviewView.as_view(), name='review'),
]