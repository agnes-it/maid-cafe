"""maidadmin URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
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
from django.urls import include, path
from django.contrib import admin
from cafe.api import api_urls
from rest_framework.authtoken.views import obtain_auth_token


urlpatterns = [
    path('api/', include(api_urls)),
    path('admin/', admin.site.urls),
    path('api-token-auth/', obtain_auth_token),
    path('api-auth/',
    include('rest_framework.urls', namespace='rest_framework')),
]