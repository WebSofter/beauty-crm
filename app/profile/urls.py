from django.urls import path

from . import views

app_name = 'profile'

urlpatterns = [
    
    # Client
    path('clients/', views.ClientListView.as_view(), name='client_list'),
    path('clients/create/', views.ClientCreateView.as_view(), name='client_create'),
    path('clients/<int:pk>/update/', views.ClientUpdateView.as_view(), name='client_update'),
    path('clients/<int:pk>/delete/', views.ClientDeleteView.as_view(), name='client_delete'),
    
    # Worker
    path('workers/', views.WorkerListView.as_view(), name='worker_list'),
    path('workers/create/', views.WorkerCreateView.as_view(), name='worker_create'),
    path('workers/<int:pk>/update/', views.WorkerUpdateView.as_view(), name='worker_update'),
    path('workers/<int:pk>/delete/', views.WorkerDeleteView.as_view(), name='worker_delete'),
    
    # Position
    path('workers/position/', views.PositionListView.as_view(), name='position_list'),
    path('workers/position/create/', views.PositionCreateView.as_view(), name='position_create'),
    path('workers/position/<int:pk>/update/', views.PositionUpdateView.as_view(), name='position_update'),
    path('workers/position/<int:pk>/delete/', views.PositionDeleteView.as_view(), name='position_delete'),
    
    # Account
    path('myaccount/', views.myaccount, name='myaccount'),
    path('sign-up/', views.signup, name='signup'),
]