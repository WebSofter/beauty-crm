from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User

from profile.models import ClientProfile, Position, WorkerProfile


INPUT_CLASS = 'w-full my-4 py-4 px-6 rounded-xl bg-gray-100'

class PositionForm(forms.ModelForm):
    class Meta:
        model = Position
        fields = ['name', 'gender']
        widgets = {
            'name': forms.TextInput(attrs={
                'placeholder': 'Название должности',
                'class': INPUT_CLASS
            }),
            'gender': forms.Select(attrs={
                'class': INPUT_CLASS
            }),
        }

class WorkerProfileForm(forms.ModelForm):
    # Определите атрибуты непосредственно при создании полей
    username = forms.CharField(widget=forms.TextInput(attrs={
        'placeholder': 'Имя пользователя',
        'class': INPUT_CLASS
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': INPUT_CLASS,
        'autocomplete': 'new-password',
    }))
    first_name = forms.CharField(widget=forms.TextInput(attrs={
        'class': INPUT_CLASS
    }))
    last_name = forms.CharField(widget=forms.TextInput(attrs={
        'class': INPUT_CLASS
    }))
    email = forms.EmailField(widget=forms.EmailInput(attrs={
        'class': INPUT_CLASS
    }))
    
    class Meta:
        model = WorkerProfile
        fields = ['username', 'password', 'first_name', 'last_name', 'email', 'position', 'hire_date', 'is_active', 'phone', 'address']
        widgets = {
            'position': forms.SelectMultiple(attrs={
                'class': INPUT_CLASS
            }),
            'hire_date': forms.DateInput(attrs={
                'placeholder': 'Дата найма',
                'type': 'date',
                'class': INPUT_CLASS,
            }),
            'is_active': forms.CheckboxInput(attrs={'class': 'ml-2'}),
            'phone': forms.TextInput(attrs={
                'placeholder': 'Телефон',
                'class': INPUT_CLASS
            }),
            'address': forms.Textarea(attrs={
                'placeholder': 'Адрес',
                'class': INPUT_CLASS,
                'rows': 2
            }),
        }
        
    def __init__(self, *args, **kwargs):
        # Вызываем родительский инициализатор
        super().__init__(*args, **kwargs)
        
        # Получаем данные из связанного User, если он существует
        if self.instance and self.instance.pk and hasattr(self.instance, 'user') and self.instance.user:
            # Заполняем начальные значения из связанного пользователя
            user = self.instance.user
            self.fields['username'].initial = user.username
            self.fields['first_name'].initial = user.first_name
            self.fields['last_name'].initial = user.last_name
            self.fields['email'].initial = user.email
        
class ClientProfileForm(forms.ModelForm):
    # Определите атрибуты непосредственно при создании полей
    username = forms.CharField(widget=forms.TextInput(attrs={
        'placeholder': 'Имя пользователя',
        'class': INPUT_CLASS
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'class': INPUT_CLASS,
        'autocomplete': 'new-password',
    }))
    first_name = forms.CharField(widget=forms.TextInput(attrs={
        'class': INPUT_CLASS
    }))
    last_name = forms.CharField(widget=forms.TextInput(attrs={
        'class': INPUT_CLASS
    }))
    email = forms.EmailField(widget=forms.EmailInput(attrs={
        'class': INPUT_CLASS
    }))
    
    class Meta:
        model = ClientProfile
        fields = ['username', 'password', 'first_name', 'last_name', 'email', 'phone', 'address', 'notes']
        widgets = {
            'phone': forms.TextInput(attrs={
                'placeholder': 'Телефон',
                'class': INPUT_CLASS
            }),
            'address': forms.Textarea(attrs={
                'placeholder': 'Адрес',
                'class': INPUT_CLASS,
                'rows': 2
            }),
            'notes': forms.Textarea(attrs={
                'placeholder': 'Заметки',
                'class': INPUT_CLASS,
                'rows': 3
            }),
        }
    
    def __init__(self, *args, **kwargs):
        # Вызываем родительский инициализатор
        super().__init__(*args, **kwargs)
        
        # Получаем данные из связанного User, если он существует
        if self.instance and self.instance.pk and hasattr(self.instance, 'user') and self.instance.user:
            # Заполняем начальные значения из связанного пользователя
            user = self.instance.user
            self.fields['username'].initial = user.username
            self.fields['first_name'].initial = user.first_name
            self.fields['last_name'].initial = user.last_name
            self.fields['email'].initial = user.email

class LoginForm(AuthenticationForm):
    username = forms.CharField(widget=forms.TextInput(attrs={
        'placeholder': 'Ваш логин',
        'class': INPUT_CLASS
    }))
    password = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder': 'Ваша пароль',
        'class': INPUT_CLASS
    }))


class SignupForm(UserCreationForm):
    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')
    
    username = forms.CharField(widget=forms.TextInput(attrs={
        'placeholder': 'Ваш логин',
        'class': INPUT_CLASS
    }))
    email = forms.CharField(widget=forms.EmailInput(attrs={
        'placeholder': 'Ваш email',
        'class': INPUT_CLASS
    }))
    password1 = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder': 'Ваша пароль',
        'class': INPUT_CLASS
    }))
    password2 = forms.CharField(widget=forms.PasswordInput(attrs={
        'placeholder': 'Повтор пароля',
        'class': INPUT_CLASS
    }))