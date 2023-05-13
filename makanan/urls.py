from django.urls import path
from .views import list_makanan, hapus_makanan, tambah_makanan, search_makanan


urlpatterns = [
	path('', list_makanan, name='list_makanan'),
	path('search/', search_makanan, name='search_makanan'),
	path('hapus/<str:nama_makanan>', hapus_makanan, name='hapus_makanan'),
	path('tambah_makanan/', tambah_makanan, name='tambah_makanan'),
]