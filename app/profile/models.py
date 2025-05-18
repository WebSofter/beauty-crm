from django.contrib.auth.models import User
from django.db import models

GENDER_CHOICES = [
    ('M', 'Мужской'),
    ('F', 'Женский'),
    ('U', 'Универсал'),
]

class Position(models.Model):
    name = models.CharField(max_length=100, unique=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, null=True)
    
    def __str__(self):
        return self.name

class BaseProfile(models.Model):
    """Абстрактная базовая модель для профилей"""
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True)
    phone = models.CharField(max_length=20, blank=True)
    address = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

class WorkerProfile(BaseProfile):
    """Профиль сотрудника"""
    hire_date = models.DateField()
    is_active = models.BooleanField(default=True)
    position = models.ManyToManyField(Position, blank=True, related_name='workers')

    def __str__(self):
        return f"Сотрудник: {self.user.get_full_name()}"

class ClientProfile(BaseProfile):
    """Профиль клиента"""
    notes = models.TextField(blank=True)
    def __str__(self):
        return f"Клиент: {self.user.get_full_name()}"
