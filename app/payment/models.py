from django.db import models
from django.conf import settings

from profile.models import WorkerProfile

class Payment(models.Model):
    worker = models.ForeignKey(WorkerProfile, on_delete=models.CASCADE, related_name='salary_payments')
    amount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Сумма выплаты")
    payment_date = models.DateField(auto_now_add=True, verbose_name="Дата выплаты")
    comment = models.TextField(blank=True, null=True, verbose_name="Комментарий")

    class Meta:
        verbose_name = "Выплата зарплаты"
        verbose_name_plural = "Выплаты зарплаты"
        ordering = ['-payment_date']

    def __str__(self):
        return f"{self.worker.user.get_full_name()} — {self.amount}₽"
