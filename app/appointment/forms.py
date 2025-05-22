from django import forms
from beautycrm.constants import FORMS
from appointment.models import Appointment, Review

class AppointmentForm(forms.ModelForm):
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



class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ('rating', 'comment')  # Только поля, которые заполняет пользователь
        widgets = {
            'rating': forms.Select(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'comment': forms.Textarea(attrs={
                'class': FORMS['FIELD_CLASS'],
                'rows': 4,
                'placeholder': 'Поделитесь своим отзывом о предоставленной услуге...'
            }),
        }