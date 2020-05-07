from django.contrib import admin
from .models import (Table, Menu, Request, Order, RequestMenu)

class RequestMenuInline(admin.TabularInline):
    model = RequestMenu
    extra = 1 # how many rows to show

class RequestAdmin(admin.ModelAdmin):
    inlines = (RequestMenuInline,)

admin.site.register(Table)
admin.site.register(Menu)
admin.site.register(Order)
admin.site.register(Request, RequestAdmin)
