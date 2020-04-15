from django.contrib import admin
from .models import (Table, Menu, Request, Order)


admin.site.register(Table)
admin.site.register(Menu)
admin.site.register(Order)
admin.site.register(Request)
