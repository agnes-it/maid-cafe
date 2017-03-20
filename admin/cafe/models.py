from django.db import models
from django.contrib.auth.models import User
import moneyed
from djmoney.models.fields import MoneyField


class Table(models.Model):
    number = models.IntegerField()
    label = models.CharField(max_length=100)

    def __str__(self):
        return self.label

    def __unicode__(self):
        return self.label

class Menu(models.Model):
    item = models.CharField(max_length=255)
    description = models.TextField()
    price = MoneyField(max_digits=10, decimal_places=2, default_currency='BRL')
    available = models.BooleanField(default=True)

    def __str__(self):
        return self.item

    def __unicode__(self):
        return self.item

class Bill(models.Model):
    maid = models.ForeignKey(User)
    client = models.CharField(max_length=255)
    table = models.ForeignKey(Table)
    start_bill = models.DateTimeField(auto_now_add=True)
    end_bill = models.DateTimeField(blank=True, null=True)
    menu = models.ManyToManyField(Menu)
    finish = models.BooleanField(default=False)
    additional_info = models.TextField(blank=True, null=True)
