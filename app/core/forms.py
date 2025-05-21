from django import forms
from beautycrm.constants import FORMS
from appointment.models import Appointment
from service.models import Service
from profile.models import WorkerProfile

class OrderNoAuthForm(forms.Form):
    name = forms.CharField(
        max_length=100,
        required=False,
        widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
    )
    phone = forms.CharField(
        max_length=20,
        required=False,
        widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
    )
    email = forms.EmailField(
        required=False,
        widget=forms.EmailInput(attrs={'class': FORMS['FIELD_CLASS']})
    )
    worker = forms.ModelChoiceField(
        queryset=WorkerProfile.objects.all(),
        widget=forms.Select(attrs={'class': FORMS['FIELD_CLASS']}),
    )
    service = forms.ModelChoiceField(
        queryset=Service.objects.all(),
        widget=forms.Select(attrs={'class': FORMS['FIELD_CLASS']})
    )
    start_time = forms.DateTimeField(widget=forms.DateTimeInput(attrs={
        'type': 'datetime-local',
        'class': FORMS['FIELD_CLASS']
    }))
    notes = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 3, 'class': FORMS['FIELD_CLASS']}),
        required=False
    )

class OrderForm(forms.ModelForm):
    class Meta:
        model = Appointment
        fields = [
            'client',
            'worker',
            'service',
            'start_time',
            'status',
            'notes',
        ]
        widgets = {
            'client': forms.Select(attrs={'class': FORMS['FIELD_CLASS']}),
            'worker': forms.Select(attrs={'class': FORMS['FIELD_CLASS']}),
            'service': forms.Select(attrs={'class': FORMS['FIELD_CLASS']}),
            'start_time': forms.DateTimeInput(attrs={
                'type': 'datetime-local',
                'class': FORMS['FIELD_CLASS']
            }),
            'status': forms.Select(attrs={'class': FORMS['FIELD_CLASS']}),
            'notes': forms.Textarea(attrs={'rows': 3, 'class': FORMS['FIELD_CLASS']}),
        }
