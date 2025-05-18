from django.db import models
from django.utils import timezone

from profile.models import ClientProfile
from profile.models import WorkerProfile
from service.models import Service

# Create your models here.

class Appointment(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Ожидает подтверждения'),
        ('confirmed', 'Подтверждена'),
        ('completed', 'Завершена'),
        ('cancelled', 'Отменена'),
    ]

    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='appointments')
    service = models.ForeignKey(Service, on_delete=models.CASCADE, related_name='appointments', null=True)
    worker = models.ForeignKey(WorkerProfile, on_delete=models.CASCADE, related_name='appointments', null=True)

    start_time = models.DateTimeField(null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    notes = models.TextField(blank=True, null=True)

    class Meta:
        ordering = ['-created_at', ]

    def __str__(self):
        return f"{self.client} — {self.service} на {self.appointment_date} {self.appointment_time}"
