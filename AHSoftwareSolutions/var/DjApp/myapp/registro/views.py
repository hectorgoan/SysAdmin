 # -*- coding: utf-8 -*-
from django.shortcuts import render, get_object_or_404, render_to_response, redirect
from django.http import HttpResponse, Http404
from django.template import RequestContext
from django.utils import timezone
from django.contrib.auth.models import User
from django.db import IntegrityError
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
import requests
import random

from registro.form import RegisterForm, RecoverPasswordForm, ChangePasswordForm

# Create your views here.
def registerView(request):
	if request.method == 'POST':
		form = RegisterForm(request.POST)
		if form.is_valid():
			 
			try:
				aNick = form.cleaned_data['Nick'].encode("utf-8")
				anEmail = form.cleaned_data['Email'].encode("utf-8")
				aNombre = form.cleaned_data['Nombre'].encode("utf-8")
				
				if User.objects.filter(email=anEmail):
					aHeader = "Error"
					aMessage = "El email "+anEmail+" ya tiene un usuario registrado"
					someExtraInfo = "Lo sentimos "+aNombre+", vuelve a probar con otra cuenta de correo"
					aButtonMsg = "Ok"
					anURL = "https://hectorgoan.noip.me/"
					aButton = "danger"
					return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
				
				
				aDireccion = form.cleaned_data['Direccion']
				aRol = form.cleaned_data['Rol']
			
				aPassword = "dia"+random.choice('abcdefghijklmnopqrstuvwxyz')+"web"+random.choice('123456789')				
				
				#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
				#he/she'll need to know the hash to actually be able to run it
				aHash = "SupaSecretPasswd"
				
				banned = ["ADMINISTRACION", "ADMIN", "ADMINISTRADOR", "ROOT", "SUDO", "APUNTES"]
				
				if aNick.upper() not in banned:
					user = User.objects.create_user(aNick, anEmail, aPassword)
					user.first_name = aNombre
					#Aprovechamos el campo last_name para guardar la direccion
					user.last_name = aDireccion
					user.save()
				
					#Registring user in server + notifying user by e-mail
					cgiURL= "https://hectorgoan.noip.me/cgi-bin/registerUser.pl?x=x&x=x&x=x&x=x&x=x&x=x&x=x"			
					url = cgiURL
					payload = {'nick': aNick, 'email': anEmail, 'password': aPassword, 'nombre': aNombre, 'direccion': aDireccion, 'rol': aRol, 'hash': aHash}
				
					r = requests.post(url, data=payload, verify=False)
				
					#Front end response
					aHeader = "Enhorabuena "+aNombre
					aMessage = "El usuario "+aNick+" ha sido registrado como "+aRol
					someExtraInfo = "Se ha enviado un mensaje en "+anEmail+" con la info de tu cuenta"
				
					return render_to_response("printer.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo})					
				
				else:
					aHeader = "Error"
					aMessage = "El usuario "+aNick+" no puede ser utilizado"
					someExtraInfo = "Lo sentimos "+aNombre+", vuelve a probar con otro nombre de usuario"
					return render_to_response("printer.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo})
				
			except IntegrityError as e:
				aHeader = "Error"
				aMessage = "El usuario "+aNick+" ya existe"
				someExtraInfo = "Lo sentimos "+aNombre+", vuelve a probar con otro nombre de usuario"
				
				return render_to_response("printer.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo})
	else:
		form = RegisterForm()
			 
	return render_to_response('registro/registerURL.html', {'form': form}, context_instance=RequestContext(request))
	
def recoverPasswordView(request):
	if request.method == 'POST':
		form = RecoverPasswordForm(request.POST)
		if form.is_valid():							 
			anEmail = form.cleaned_data['Email'].encode("utf-8")
			
			#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
			#he/she'll need to know the hash to actually be able to run it
			aHash = "PasswdSupaSecret"
			
			try:
				User.objects.get(email = anEmail)
					
			except User.DoesNotExist: #No daremos pistas de que mails están registrados y cuales no, por tanto, mismo mensaje aunque no hacemos nada				
				aHeader = "Hecho"
				aMessage = "Mensaje enviado a "+anEmail
				someExtraInfo = "Encontrarás las instrucciones para volver a iniciar sesión"
			
				return render_to_response("printer.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo})	
				
			user = User.objects.get(email = anEmail)
			aPassword = "web"+random.choice('123456789')+"dia"+random.choice('abcdefghijklmnopqrstuvwxyz')
			#aPassword = "paco"
			user.set_password(aPassword)
			user.save()
			
			#Changing passwd in server + e-mailing user
			cgiURL= "https://hectorgoan.noip.me/cgi-bin/changePassUser.pl?x=x&x=x&x=x"			
			url = cgiURL
			payload = {'nick': user.username, 'email': anEmail, 'password': aPassword, 'hash': aHash}
				
			r = requests.post(url, data=payload, verify=False)
			
			
			#Front-end notifying
			aHeader = "Hecho" #+ user.username Desactivamos esto para no dar pistas de usuarios existentes
			aMessage = "Mensaje enviado a "+anEmail
			someExtraInfo = "Encontrarás las instrucciones para volver a iniciar sesión"
				
			return render_to_response("printer.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo})	
			
			
	else:
		form = RecoverPasswordForm()
			 
	return render_to_response('registro/recoverURL.html', {'form': form}, context_instance=RequestContext(request))
	
@login_required
def changePasswordView(request):
	if request.method == 'POST':
		form = ChangePasswordForm(request.POST)
		if form.is_valid():
			aPassword1 = form.cleaned_data['NewPassword'].encode("utf-8")
			aPassword2 = form.cleaned_data['RepeatPassword'].encode("utf-8")
			aPassword = str(aPassword1)
			
			#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
			#he/she'll need to know the hash to actually be able to run it
			aHash = "PasswdSupaSecret"
			
			if aPassword1 == aPassword2:
				
				#Change passwd in Django
				request.user.set_password(aPassword)
				request.user.save()
			
				#Changing passwd in server + e-mailing user
				cgiURL= "https://hectorgoan.noip.me/cgi-bin/changePassUser.pl?x=x&x=x&x=x"			
				url = cgiURL
				payload = {'nick': request.user.username, 'email': request.user.email, 'password': aPassword, 'hash': aHash}
				
				r = requests.post(url, data=payload, verify=False)
			
				#log-out
				logout(request)
				
				aHeader = "Hecho"
				aMessage = "Se te ha enviado un email"
				someExtraInfo = "Encontrarás la nueva información de inicio de sesión"
				aButtonMsg = "Ok"
				anURL = "https://hectorgoan.noip.me/"
				aButton = "info"
				return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
			
			else:
				aHeader = "Error"
				aMessage = "Las contraseñas no coinciden"
				someExtraInfo = "Tendrás que volver a intentarlo"
				aButtonMsg = "Volver a intentar"
				anURL = "https://hectorgoan.noip.me/miapp/changePasswd"
				aButton = "danger"
				return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})		
	
	else:
		form = ChangePasswordForm()
		
	return render_to_response('registro/changePasswdURL.html', {'form': form}, context_instance=RequestContext(request))
	
@login_required
def checkout_view(request):
	
	#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
	#he/she'll need to know the hash to actually be able to run it
	aHash = "PasswdMEOWbarf"
	
	#Removing user in server + e-mailing user
	cgiURL= "https://hectorgoan.noip.me/cgi-bin/deleteUser.pl?x=x&x=x&x=x&x=x"			
	url = cgiURL
	payload = {'nick': request.user.username, 'email': request.user.email, 'nombre': request.user.first_name, 'hash': aHash}
				
	r = requests.post(url, data=payload, verify=False)
	
	#Remove user in Django
	request.user.delete()

	aHeader = "Hecho"
	aMessage = "Tu cuenta y tus datos han sido eliminados"
	someExtraInfo = "Tendrás que volver a registrarte para utilizar el sistema"
	aButtonMsg = "Ok"
	anURL = "https://hectorgoan.noip.me/"
	aButton = "info"
	return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
	