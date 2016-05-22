 # -*- coding: utf-8 -*-
from django import forms

class RegisterForm(forms.Form):
	Nombre = forms.CharField(max_length= 30, required= True)
	Nick = forms.CharField(max_length= 30, required= True)	
	Email = forms.EmailField(max_length= 100, required= True)
	#Password = forms.CharField(max_length= 100, required= True, widget=forms.PasswordInput)
	Direccion = forms.CharField(max_length= 30, required= True)
	
	Opciones=[('Alumno','Alumno'), ('Profesor','Profesor')]
	Rol = forms.ChoiceField(choices=Opciones, widget=forms.RadioSelect())
	
class RecoverPasswordForm(forms.Form):
	Email = forms.EmailField(max_length= 100, required= True)
	
class ChangePasswordForm(forms.Form):
	NewPassword = forms.CharField(max_length= 100, required= True, widget=forms.PasswordInput)
	RepeatPassword = forms.CharField(max_length= 100, required= True, widget=forms.PasswordInput)
	
	