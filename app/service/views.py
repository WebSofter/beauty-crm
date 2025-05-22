from django.shortcuts import render
from django.contrib.auth.decorators import login_required
# Create your views here.
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import redirect, get_object_or_404
from django.urls import reverse_lazy
from django.views import View
from django.views.generic import ListView, DetailView, DeleteView, UpdateView, CreateView

from appointment.models import Appointment

from .forms import ServiceCategoryForm, ServiceForm
from .models import Service, ServiceCategory

class ServiceListView(LoginRequiredMixin, ListView):
    model = Service
    
    def get_queryset(self):
        queryset = super(ServiceListView, self).get_queryset()
        return queryset.all()

class ServiceCreateView(LoginRequiredMixin, CreateView):
    model = Service
    fields = ('category', 'name', 'gender', 'description', 'duration', 'price', 'is_active',)
    success_url = reverse_lazy('services:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        context['form'] = ServiceForm()
        context['title'] = 'Добавить услугу'

        return context

    def form_valid(self, form):
        self.object = form.save(commit=False)
        self.object.created_by = self.request.user
        self.object.save()
        
        return redirect(self.get_success_url())
class ServiceDetailView(LoginRequiredMixin, DetailView):
    model = Service
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['form'] = ServiceForm()
        context['category_form'] = ServiceCategoryForm()

        return context

    def get_queryset(self):
        queryset = super(ServiceDetailView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))
    
class ServiceDeleteView(LoginRequiredMixin, View):
    def post(self, request, pk):
        category = get_object_or_404(Service, pk=pk)
        # можно добавить проверку доступа
        category.delete()
        return redirect('services:list')

    def get(self, request, *args, **kwargs):
        # запретить или сделать редирект
        return redirect('services:list')

class ServiceUpdateView(LoginRequiredMixin, UpdateView):
    model = Service
    form_class = ServiceForm
    success_url = reverse_lazy('services:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Изменить услугу'

        return context

    def get_queryset(self):
        queryset = super(ServiceUpdateView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))

###
## Service category
###
class ServiceCategoryListView(LoginRequiredMixin, ListView):
    model = ServiceCategory
    template_name = 'service/category_list.html'
    success_url = reverse_lazy('services:category_list')
    
    def get_queryset(self, **kwargs):
        queryset = super(ServiceCategoryListView, self).get_queryset()
        return queryset.all()
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Категории услуг'
        return context

class ServiceCategoryCreateView(LoginRequiredMixin, CreateView):
    model = ServiceCategory
    form_class = ServiceCategoryForm
    template_name = 'service/category_form.html'
    success_url = reverse_lazy('services:category_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Добавить категорию'
        return context

    def form_valid(self, form):
        self.object = form.save(commit=False)
        self.object.save()
        
        return redirect(self.get_success_url())

class ServiceCategoryUpdateView(LoginRequiredMixin, UpdateView):
    model = ServiceCategory
    form_class = ServiceCategoryForm
    template_name = 'service/category_form.html'
    success_url = reverse_lazy('services:category_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Изменить услугу'

        return context

    def get_queryset(self):
        queryset = super(ServiceCategoryUpdateView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))
    
# class ServiceCategoryDeleteView(LoginRequiredMixin, DeleteView):
#     model = ServiceCategory
#     success_url = reverse_lazy('services:category_list')

#     def get_queryset(self):
#         queryset = super().get_queryset()
#         return queryset.filter(pk=self.kwargs.get('pk'))

class ServiceCategoryDeleteView(LoginRequiredMixin, View):
    def post(self, request, pk):
        print(pk)
        category = get_object_or_404(ServiceCategory, pk=pk)
        # можно добавить проверку доступа
        category.delete()
        return redirect('services:category_list')

    def get(self, request, *args, **kwargs):
        # запретить или сделать редирект
        return redirect('services:category_list')
