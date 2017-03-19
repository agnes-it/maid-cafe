from django.db import models
import moneyed
from djmoney.models.fields import MoneyField


class Table(models.Model):
    number = models.IntegerField()
    label = models.CharField(max_length=100)

class Menu(models.Model):
    item = models.CharField(max_length=255)
    description = models.TextField()
    price = MoneyField(max_digits=10, decimal_places=2, default_currency='BRL')
    available = models.BooleanField(default=True)

class Bill(models.Model):
    client = models.CharField(max_length=255)
    table = models.ForeignKey(Table)
    start_bill = models.DateTimeField(auto_now_add=True)
    end_bill = models.DateTimeField(blank=True)
    menu = models.ManyToManyField(Menu)
