from django.http import JsonResponse
from datetime import datetime

def server_time(request):
    response = {
        "server_date": str(datetime.now())
    }

    return JsonResponse(response)
