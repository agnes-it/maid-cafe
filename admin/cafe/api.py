from django.conf.urls import url, include
from django.contrib.auth.models import User
from .models import Order, Request, Table, Menu
from rest_framework import routers, serializers, viewsets
from rest_framework.validators import UniqueValidator
from rest_framework.permissions import IsAuthenticated
from cafe.helpers import server_time


# Serializers define the API representation.
class RequestSerializer(serializers.HyperlinkedModelSerializer):
    maid = serializers.SlugRelatedField(queryset=User.objects.all(), slug_field="username")
    table = serializers.SlugRelatedField(queryset=Table.objects.all(), slug_field="label")
    menu = serializers.SlugRelatedField(queryset=Menu.objects.all(), many=True, slug_field="item")

    class Meta:
        model = Request
        fields = ('id', 'maid', 'client', 'table',
                  'start_at', 'end_at', 'menu', 'finish', 'additional_info')

class OrderSerializer(serializers.HyperlinkedModelSerializer):
    table = serializers.SlugRelatedField(queryset=Table.objects.all(), slug_field="label")
    
    class Meta:
        model = Order
        fields = ('id', 'table', 'start_at', 'end_at', 'paid')

class TableSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Table
        fields = ('id', 'number', 'label')

class MenuSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Menu
        fields = ('id', 'item', 'description', 'price', 'available')

# ViewSets define the view behavior.
class RequestViewSet(viewsets.ModelViewSet):
    queryset = Request.objects.filter(finish=False)
    serializer_class = RequestSerializer

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.filter(paid=False)
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

class TableViewSet(viewsets.ModelViewSet):
    queryset = Table.objects.all()
    serializer_class = TableSerializer
    permission_classes = [IsAuthenticated]

class MenuViewSet(viewsets.ModelViewSet):
    queryset = Menu.objects.filter(available=True)
    serializer_class = MenuSerializer
    permission_classes = [IsAuthenticated]

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'requests', RequestViewSet)
router.register(r'orders', OrderViewSet)

api_urls = router.urls + [
    url(r'^server_time', server_time)
]
router.register(r'tables', TableViewSet)
router.register(r'menus', MenuViewSet)
