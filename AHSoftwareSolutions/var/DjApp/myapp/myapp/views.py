# coding=utf-8
from django.template import RequestContext
from django.shortcuts import render_to_response, redirect
from myapp.forms import LoginForm, SettingsForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
import requests

def login_page(request):
    message = None
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            username = request.POST['username']
            password = str(request.POST['password'])
            user = authenticate(username=username, password=password)
            if user is not None:
                if user.is_active:
                    login(request, user)
                    ip = get_client_ip(request)
                    mode = "debug"
                    if username == "administrador":
                    	aHash = "MEOWPasswdCoffe"
                    	#Call cgi script to notifiy that "administrador" have loggued in
                    	cgiURL= "https://hectorgoan.noip.me/cgi-bin/notification.pl?x=x&x=x"
                    	url = cgiURL
                    	payload = {'ip': ip, 'hash': aHash, 'mode': mode}
                    	r = requests.post(url, data=payload, verify=False)
                    
                    aHash = "ITS3am"
                    #Call cgi script to write in log
                    cgiURL= "https://hectorgoan.noip.me/cgi-bin/loginlog.pl?x=x&x=x&x=x&x=x"
                    url = cgiURL
                    payload = {'ip': ip, 'hash': aHash, 'username': username, 'mode': mode}
                    r = requests.post(url, data=payload, verify=False)
                    
                    return redirect("https://hectorgoan.noip.me/miapp/")
                else:                    
                    return redirect("https://hectorgoan.noip.me/miapp/")
            else:
            	ip = get_client_ip(request)
            	mode = "warning"
            	if username == "administrador":
            		aHash = "MEOWPasswdCoffe"
            		#Call cgi script to notifiy that "administrador" have loggued in
            		cgiURL= "https://hectorgoan.noip.me/cgi-bin/notification.pl?x=x&x=x"
            		url = cgiURL
            		payload = {'ip': ip, 'hash': aHash, 'mode': mode}
            		r = requests.post(url, data=payload, verify=False)
            	
            	aHash = "ITS3am"
            	cgiURL= "https://hectorgoan.noip.me/cgi-bin/loginlog.pl?x=x&x=x&x=x&x=x"
            	url = cgiURL
            	payload = {'ip': ip, 'hash': aHash, 'username': username, 'mode': mode}
            	r = requests.post(url, data=payload, verify=False)
            
                message = "Nombre de usuario y/o password incorrecto"
    else:
        form = LoginForm()
    
    return render_to_response('login.html', {'message': message, 'form': form}, context_instance=RequestContext(request))                            
    
@login_required
def homepage(request):
    return render_to_response('homepage.html',
           context_instance=RequestContext(request))
           
           
@login_required
def settings_page(request):
    message = None
    if request.method == "POST":
    	form = SettingsForm(request.POST)
    	if form.is_valid():
    		anEmail = form.cleaned_data['Email']
    		aName = form.cleaned_data['Nombre']
    		aDireccion = form.cleaned_data['Direccion']
    		
    		if User.objects.filter(email=anEmail):
    			aHeader = "Error"
    			aMessage = "El email "+anEmail+" ya tiene un usuario registrado"
    			someExtraInfo = "Lo sentimos "+aName+", vuelve a probar con otra cuenta de correo"
    			aButtonMsg = "Ok"
    			anURL = "https://hectorgoan.noip.me/miapp/settings"
    			aButton = "danger"
    			return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
    		
    		request.user.first_name=aName
    		request.user.last_name=aDireccion
    		request.user.email=anEmail
    		
    		request.user.save()
    		
    		return redirect("https://hectorgoan.noip.me/miapp/settings/")
    else:
    	form = SettingsForm()
    
    return render_to_response('settings.html', {'message': message, 'form': form}, context_instance=RequestContext(request))


def logout_view(request):
	logout(request)
	return redirect("https://hectorgoan.noip.me")

@login_required
def createBlog(request):
	
	#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
	#he/she'll need to know the hash to actually be able to run it
	aHash = "MEOWbarfPasswd"
	
	#Call cgi script that copies CMS files to public_html
	cgiURL= "https://hectorgoan.noip.me/cgi-bin/createBlog.pl?x=x&x=x"			
	url = cgiURL
	payload = {'nick': request.user.username, 'hash': aHash}
				
	r = requests.post(url, data=payload, verify=False)


	aHeader = "Hecho"
	aMessage = "Tu blog ha sido creado, a continuación tendrás que configurarlo"
	someExtraInfo = "En cualquier momento puedes eliminarlo desde el panel de tu perfil"
	aButtonMsg = "Configurar"
	anURL = "https://hectorgoan.noip.me/~"+request.user.username+"/admin/"
	aButton = "info"
	return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
	
@login_required
def deleteBlog(request):
	
	#Security measure, even if someone by any chance discovers the number & name of the arguments to call the cgi 
	#he/she'll need to know the hash to actually be able to run it
	aHash = "barfMEOWPasswd"
	
	#Call cgi script that copies CMS files to public_html
	cgiURL= "https://hectorgoan.noip.me/cgi-bin/deleteBlog.pl?x=x&x=x"			
	url = cgiURL
	payload = {'nick': request.user.username, 'hash': aHash}
				
	r = requests.post(url, data=payload, verify=False)


	aHeader = "Hecho"
	aMessage = "Tu blog ha sido eliminado, ahora podrás crear tu propia web subiéndola a public_html"
	someExtraInfo = "En cualquier momento puedes reactivar el blog desde el panel de tu perfil"
	aButtonMsg = "Ok"
	anURL = "https://hectorgoan.noip.me/miapp/"
	aButton = "info"
	return render_to_response("recoverPrinter.html", {"header": aHeader, "message": aMessage, "extrainfo": someExtraInfo, "url": anURL, "buttonmsg": aButtonMsg, "button": aButton})
		
	
	#Other functions
def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip