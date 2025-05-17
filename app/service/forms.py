from django import forms

from beautycrm.constants import FORMS

from .models import Service, ServiceCategory

class ServiceCategoryForm(forms.ModelForm):
    class Meta:
        model = ServiceCategory
        fields = ('name', 'description', 'is_active',)
        widgets = {
            'name': forms.TextInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'description': forms.Textarea(attrs={
                'class': FORMS['FIELD_CLASS'],
                'rows': 4
            }),
            'is_active': forms.CheckboxInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
        }
        
class ServiceForm(forms.ModelForm):
    class Meta:
        model = Service
        fields = ('category', 'name', 'description', 'duration', 'price', 'is_active')
        widgets = {
            'category': forms.Select(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'name': forms.TextInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'description': forms.Textarea(attrs={
                'class': FORMS['FIELD_CLASS'],
                'rows': 4
            }),
            'duration': forms.NumberInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'price': forms.NumberInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
            'is_active': forms.CheckboxInput(attrs={
                'class': FORMS['FIELD_CLASS'],
            }),
        }