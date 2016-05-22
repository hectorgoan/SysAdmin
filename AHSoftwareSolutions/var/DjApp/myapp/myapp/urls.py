"""myapp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, patterns, include 
from django.contrib import admin

admin.autodiscover()

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^admin/doc', include('django.contrib.admindocs.urls')),
    url(r'^registro/$', 'registro.views.registerView', name='registro'),
    url(r'^recuperarPasswd/$', 'registro.views.recoverPasswordView', name='recuperarPasswd'),
    url(r'^login/$', 'myapp.views.login_page', name="login"),
    url(r'^$', 'myapp.views.homepage', name="homepage"),
    url(r'^logout/$', 'myapp.views.logout_view', name="logout"),
    url(r'^settings/$', 'myapp.views.settings_page', name="settings"),
    url(r'^changePasswd/$', 'registro.views.changePasswordView', name='changePasswd'),
    url(r'^checkout/$', 'registro.views.checkout_view', name="checkout"),
    url(r'^configureBlog/$', 'myapp.views.createBlog', name="configureBlog"),
    url(r'^deleteBlog/$', 'myapp.views.deleteBlog', name="deleteBlog"),
]
