from django.urls import path
from .views import index, list_makanan


urlpatterns = [
	path('', index, name='index'),
	path('makanan', list_makanan, name='makanan'),
]