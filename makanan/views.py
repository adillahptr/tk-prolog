from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse

from tk_prolog import process

def index(request):
	x = process('data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return HttpResponse(x)

def list_makanan(request):
	result = process('data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return render(request, 'list_makanan.html', context = {'makanan':result})

def tambah_makanan(request):
	if request.method == 'POST':
		try:

			result = process('tambah_makanan(M, L, P, K, V, JV, H, IG, C)')
		except:
			context = {'error':'error'}
	return redirect('list_makanan')

def update_makanan(request):
	if request.method == 'POST':
		try:
			result = process('update_makanan(M, L, P, K, V, JV, H, IG, C)')
		except:
			context = {'error':'error'}
	return redirect('list_makanan')

def hapus_makanan(request, nama_makanan):
	try:
		result = process(f"delete_makanan('{nama_makanan}')")
	except:
		print('error')
		context = {'error':'Gagal menghapus makanan'}
	return redirect('list_makanan')