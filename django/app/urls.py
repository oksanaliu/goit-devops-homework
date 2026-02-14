"""
URL configuration for app project.
"""
from django.contrib import admin
from django.urls import path
from django.http import HttpResponse

def health_check(request):
    return HttpResponse("<h1>Django App is Running! </h1><p>DevOps Final Project</p>")

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', health_check),
    path('health/', health_check),
]

