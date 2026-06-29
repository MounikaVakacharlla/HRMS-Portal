from django.contrib import admin
from .models import Employee
admin.site.register(Employee)

from django.contrib import admin

admin.site.site_header = "HRMS Portal"
admin.site.site_title = "HRMS Portal"
admin.site.index_title = "Welcome to HRMS Portal"