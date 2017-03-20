from django.conf.urls import url, include
from django.contrib.auth.models import User
from .models import Bill, Table, Menu
from rest_framework import routers, serializers, viewsets
from rest_framework.validators import UniqueValidator

# Serializers define the API representation.
class BillSerializer(serializers.HyperlinkedModelSerializer):
    maid = serializers.SlugRelatedField(queryset=User.objects.all(), slug_field="username")
    table = serializers.SlugRelatedField(queryset=Table.objects.all(), slug_field="label")
    menu = serializers.SlugRelatedField(queryset=Menu.objects.all(), many=True, slug_field="item")

    class Meta:
        model = Bill
        fields = ('id', 'maid', 'client', 'table',
                  'start_bill', 'end_bill', 'menu', 'finish', 'additional_info')

# ViewSets define the view behavior.
class BillViewSet(viewsets.ModelViewSet):
    queryset = Bill.objects.filter(finish=False)
    serializer_class = BillSerializer

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'bills', BillViewSet)
