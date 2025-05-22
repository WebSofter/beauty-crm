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
        return f"{self.client} — {self.service}"


class Review(models.Model):
    RATING_CHOICES = [
        (1, '1 звезда'),
        (2, '2 звезды'),
        (3, '3 звезды'), 
        (4, '4 звезды'),
        (5, '5 звезд'),
    ]

    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='reviews')
    worker = models.ForeignKey(WorkerProfile, on_delete=models.CASCADE, related_name='reviews')
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, related_name='reviews')  # Исправлено: apointment -> appointment
    rating = models.IntegerField(choices=RATING_CHOICES)
    comment = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        indexes = [
            models.Index(fields=['client'], name='idx_review_client'),
            models.Index(fields=['worker'], name='idx_review_worker'),
            models.Index(fields=['appointment'], name='idx_review_appointment'),  # Исправлено: appointment
        ]
        # Рекомендуется добавить уникальное ограничение
        unique_together = ['client', 'appointment']

    def __str__(self):
        return f'Отзыв от {self.client} для {self.worker} - {self.rating} звезд'