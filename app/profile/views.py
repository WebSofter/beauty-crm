from django.contrib.auth.decorators import login_required
from django.http import Http404
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib.auth.models import User
from .forms import PositionForm, SignupForm, WorkerProfileForm
from .models import ClientProfile, Position, WorkerProfile
from django.views.generic import ListView, CreateView, UpdateView, DeleteView

from django.urls import reverse_lazy
from .forms import ClientProfileForm

###
## Client Views
###
class ClientListView(ListView):
    model = ClientProfile
    template_name = 'profile/client_list.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['create'] = 'profile:client_create'
        context['title'] = 'Клиенты'
        
        return context
    
    def get_queryset(self):
        queryset = super(ClientListView, self).get_queryset()
        return queryset.all()

class ClientCreateView(CreateView):
    model = ClientProfile
    form_class = ClientProfileForm
    template_name = 'profile/form.html'
    success_url = reverse_lazy('profile:client_list')
    

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Добавить работника'

        return context

    def form_valid(self, form):
        user = User.objects.create_user(
            username=form.cleaned_data['username'],
            password=form.cleaned_data['password'],
            first_name=form.cleaned_data['first_name'],
            last_name=form.cleaned_data['last_name'],
            email=form.cleaned_data['email'],
        )

        ClientProfile.objects.create(
            user=user,
            phone=form.cleaned_data['phone'],
            address=form.cleaned_data['address'],
            notes=form.cleaned_data['notes'],
        )

        return redirect(self.success_url)

    # def form_valid(self, form):
    #     user = User.objects.create_user(
    #         username=form.cleaned_data['username'],
    #         password=form.cleaned_data['password'],
    #         first_name=form.cleaned_data['first_name'],
    #         last_name=form.cleaned_data['last_name'],
    #         email=form.cleaned_data['email'],
    #     )

    #     ClientProfile.objects.create(
    #         user=user,
    #         phone=form.cleaned_data['phone'],
    #         address=form.cleaned_data['address'],
    #         notes=form.cleaned_data['notes'],
    #     )
        
    #     return super().form_valid(form)

class ClientUpdateView(UpdateView):
    model = ClientProfile
    form_class = ClientProfileForm
    template_name = 'profile/form.html'
    success_url = reverse_lazy('profile:client_list')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Редактировать клиента'
        return context
    
    def form_valid(self, form):
        # 1. Получаем профиль и связанного пользователя
        profile = form.save(commit=False)
        user = profile.user
        # 2. Обновляем данные пользователя из очищенных данных формы
        if user:
            user.username = form.cleaned_data.get('username', user.username)
            user.first_name = form.cleaned_data.get('first_name', user.first_name)
            user.last_name = form.cleaned_data.get('last_name', user.last_name)
            user.email = form.cleaned_data.get('email', user.email)
        else:
            user = User.objects.create_user(
                username=form.cleaned_data['username'],
                # password=form.cleaned_data['new_password'],
                first_name=form.cleaned_data['first_name'],
                last_name=form.cleaned_data['last_name'],
                email=form.cleaned_data['email'],
            )
            profile.user = user
        
        # Обновляем пароль только если он был предоставлен
        password = form.cleaned_data.get('password')
        if password:
            user.set_password(password)
            
        user.save()
        profile.save()

        from django.contrib import messages
        messages.success(self.request, f'Профиль сотрудника {user.get_full_name()} успешно обновлен')
            
        return redirect(self.get_success_url())

class ClientDeleteView(DeleteView):
    model = ClientProfile
    template_name = 'profile/detail.html'
    success_url = reverse_lazy('profile:client_list')

###
## Worker Views
###
class WorkerListView(ListView):
    model = WorkerProfile
    template_name = 'profile/worker_list.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['create'] = 'profile:worker_create'
        context['title'] = 'Работники'
        
        return context
    
    def get_queryset(self):
        queryset = super(WorkerListView, self).get_queryset().select_related('user').prefetch_related('position')
        profiles = queryset.all()
        for profile in profiles:
            print(profile.position.all())
        return profiles

class WorkerCreateView(CreateView):
    model = WorkerProfile
    form_class = WorkerProfileForm
    template_name = 'profile/form.html'
    success_url = reverse_lazy('profile:worker_list')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Добавить работника'

        return context

    def form_valid(self, form):
        # 1. Создаём пользователя
        user = User.objects.create_user(
            username=form.cleaned_data['username'],
            password=form.cleaned_data['password'],
            first_name=form.cleaned_data['first_name'],
            last_name=form.cleaned_data['last_name'],
            email=form.cleaned_data['email'],
        )

        # 2. Сохраняем профиль без ManyToMany-поля
        profile = WorkerProfile.objects.create(
            user=user,
            hire_date=form.cleaned_data['hire_date'],
            phone=form.cleaned_data['phone'],
            address=form.cleaned_data['address'],
            is_active=True,
        )

        # 3. Назначаем позиции (ManyToMany)
        profile.position.set(form.cleaned_data['position'])

        return super().form_valid(form)

class WorkerUpdateView(UpdateView):
    model = WorkerProfile
    form_class = WorkerProfileForm
    template_name = 'profile/form.html'
    success_url = reverse_lazy('profile:worker_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Редактировать работника'
        # Можно добавить дополнительные данные в контекст
        # context['worker'] = self.get_object()
        return context

    # def get_initial(self):
    #     """Предзаполняем данные из связанного пользователя"""
    #     initial = super().get_initial()
    #     profile = self.get_object()
    #     if profile and profile.user:
    #         user = profile.user
    #         initial.update({
    #             'username': user.username,
    #             'first_name': user.first_name,
    #             'last_name': user.last_name,
    #             'email': user.email,
    #         })
    #     return initial

    def form_valid(self, form):
        # 1. Получаем профиль и связанного пользователя
        profile = form.save(commit=False)
        user = profile.user
        # 2. Обновляем данные пользователя из очищенных данных формы
        if user:
            user.username = form.cleaned_data.get('username', user.username)
            user.first_name = form.cleaned_data.get('first_name', user.first_name)
            user.last_name = form.cleaned_data.get('last_name', user.last_name)
            user.email = form.cleaned_data.get('email', user.email)
        else:
            user = User.objects.create_user(
                username=form.cleaned_data['username'],
                # password=form.cleaned_data['new_password'],
                first_name=form.cleaned_data['first_name'],
                last_name=form.cleaned_data['last_name'],
                email=form.cleaned_data['email'],
            )
            profile.user = user
        
        # Обновляем пароль только если он был предоставлен
        password = form.cleaned_data.get('password')
        if password:
            user.set_password(password)
            
        # Сохраняем изменения пользователя
        user.save()

        # 3. Сохраняем профиль
        profile.save()

        # 4. Обновляем ManyToMany — позиции
        if 'position' in form.cleaned_data:
            profile.position.set(form.cleaned_data['position'])
            
        from django.contrib import messages
        messages.success(self.request, f'Профиль сотрудника {user.get_full_name()} успешно обновлен')
            
        return redirect(self.get_success_url())

class WorkerDeleteView(DeleteView):
    model = WorkerProfile
    template_name = 'profile/detail.html'
    success_url = reverse_lazy('profile:worker_list')

###
## Worker Position
###
class PositionListView(ListView):
    model = Position
    template_name = 'position/list.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Специализации'
        
        return context
    
    def get_queryset(self):
        queryset = super(PositionListView, self).get_queryset()
        return queryset.all()

class PositionCreateView(CreateView):
    model = Position
    form_class = PositionForm
    template_name = 'position/form.html'
    success_url = reverse_lazy('profile:position_list')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Добавить специализацию'

        return context

    def form_valid(self, form):
        self.object = form.save(commit=False)
        user = self.request.user
        self.object.user = user
        self.object.save()
        
        return redirect(self.get_success_url())

class PositionUpdateView(UpdateView):
    model = Position
    form_class = PositionForm
    template_name = 'position/form.html'
    success_url = reverse_lazy('profile:position_list')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Изменить позицию'

        return context

    def get_queryset(self):
        queryset = super(PositionUpdateView, self).get_queryset()
        return queryset.filter(pk=self.kwargs.get('pk'))

class PositionDeleteView(DeleteView):
    def post(self, request, pk):
        category = get_object_or_404(Position, pk=pk)
        # можно добавить проверку доступа
        category.delete()
        return redirect('profile:position_list')

    def get(self, request, *args, **kwargs):
        # запретить или сделать редирект
        return redirect('profile:position_list')
    
###Position.objects.filter(pk=2).exists()
## Auth Views
###
def signup(request):
    if request.method == 'POST':
        form = SignupForm(request.POST)

        if form.is_valid():
            user = form.save()

            ClientProfile.objects.create(user=user,)

            return redirect('/log-in/')
    else:
        form = SignupForm()

    return render(request, 'account/signup.html', {
        'form': form
    })

@login_required
def myaccount(request):
    return render(request, 'account/myaccount.html')