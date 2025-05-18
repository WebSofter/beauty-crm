from django.shortcuts import render

# Create your views here.
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import redirect, get_object_or_404
from django.urls import reverse_lazy
from django.views import View
from django.views.generic import ListView, DetailView, DeleteView, UpdateView, CreateView

from .forms import AppointmentForm
from .models import Appointment

class AppointmentListView(LoginRequiredMixin, ListView):
    model = Appointment
    
    def get_queryset(self):
        queryset = super(AppointmentListView, self).get_queryset()
        return queryset.all()

class AppointmentCreateView(LoginRequiredMixin, CreateView):
    model = Appointment
    form_class = AppointmentForm
    success_url = reverse_lazy('appointment:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        context['form'] = AppointmentForm()
        context['title'] = 'Добавить запись'

        return context

    def form_valid(self, form):
        self.object = form.save(commit=False)
        self.object.created_by = self.request.user
        self.object.save()
        
        return redirect(self.get_success_url())
class AppointmentDetailView(LoginRequiredMixin, DetailView):
    model = Appointment
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['form'] = AppointmentForm()

        return context

    def get_queryset(self):
        queryset = super(AppointmentDetailView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))
    
class AppointmentDeleteView(LoginRequiredMixin, View):
    def post(self, request, pk):
        category = get_object_or_404(Appointment, pk=pk)
        # можно добавить проверку доступа
        category.delete()
        return redirect('appointment:list')

    def get(self, request, *args, **kwargs):
        # запретить или сделать редирект
        return redirect('appointment:list')

class AppointmentUpdateView(LoginRequiredMixin, UpdateView):
    model = Appointment
    form_class = AppointmentForm
    success_url = reverse_lazy('appointment:list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Изменить запись'

        return context

    def get_queryset(self):
        queryset = super(AppointmentUpdateView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))
