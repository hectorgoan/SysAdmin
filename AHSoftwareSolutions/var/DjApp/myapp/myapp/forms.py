from django import forms

class LoginForm(forms.Form):
	username = forms.CharField()
	password = forms.CharField(widget=forms.PasswordInput())
	
class SettingsForm(forms.Form):
	Nombre = forms.CharField(max_length= 30, required= True)
	Email = forms.EmailField(max_length= 100, required= True)
	Direccion = forms.CharField(max_length= 30, required= True)
	