from django.contrib import admin

from .models import WorkerProfile, ClientProfile

admin.site.register(WorkerProfile)
admin.site.register(ClientProfile)