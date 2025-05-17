from django.urls import path

from . import views

app_name = 'services'

urlpatterns = [
    # Услуги
    path('', views.ServiceListView.as_view(), name='list'),
    path('create/', views.ServiceCreateView.as_view(), name='create'),
    path('<int:pk>/', views.ServiceDetailView.as_view(), name='detail'),
    path('<int:pk>/update/', views.ServiceUpdateView.as_view(), name='update'),
    path('<int:pk>/delete/', views.ServiceDeleteView.as_view(), name='delete'),
    # Категории услуг
    path('category/', views.ServiceCategoryListView.as_view(), name='category_list'),
    path('category/create/', views.ServiceCategoryCreateView.as_view(), name='category_create'),
    path('category/<int:pk>/update/', views.ServiceCategoryUpdateView.as_view(), name='category_update'),
    path('category/<int:pk>/delete/', views.ServiceCategoryDeleteView.as_view(), name='category_delete'),
]