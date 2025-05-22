from django import forms
from payment.models import Payment
from beautycrm.constants import FORMS
from appointment.models import Appointment
from service.models import Service
from profile.models import WorkerProfile

class SalaryForm(forms.ModelForm):
    bonuses = forms.IntegerField(
        required=False,
        widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
    )
    salary = forms.DecimalField(
        required=False,
        widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
    )

    class Meta:
        model = WorkerProfile
        fields = ['bonuses', 'salary']
        
        
# class PaymentForm(forms.ModelForm):
#     worker = forms.ModelChoiceField(
#         required=False,
#         queryset=WorkerProfile.objects.all(),
#         widget=forms.Select(attrs={'class': FORMS['FIELD_CLASS'], 'disabled': True})
#     )
#     amount = forms.IntegerField(
#         required=False,
#         widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
#     )
#     comment = forms.CharField(
#         required=False,
#         widget=forms.Textarea(attrs={'class': FORMS['FIELD_CLASS']})
#     )

#     class Meta:
#         model = Payment
#         fields = ['worker', 'amount', 'comment']

class PaymentForm(forms.ModelForm):
    worker = forms.ModelChoiceField(
        required=True,
        queryset=WorkerProfile.objects.all(),
        widget=forms.HiddenInput()  # раньше был Select с disabled
    )
    amount = forms.IntegerField(
        required=False,
        widget=forms.TextInput(attrs={'class': FORMS['FIELD_CLASS']})
    )
    comment = forms.CharField(
        required=False,
        widget=forms.Textarea(attrs={'class': FORMS['FIELD_CLASS']})
    )

    class Meta:
        model = Payment
        fields = ['worker', 'amount', 'comment']