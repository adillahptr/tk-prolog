from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse

from tk_prolog import process

def list_makanan(request):
	result = process('data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return render(request, 'list_makanan.html', context = {'makanan':result})

def tambah_makanan(request):
	if request.method == 'POST':
		try:
			nama = request.POST.get('makanan')
			lemak = request.POST.get('lemak')
			protein = request.POST.get('protein')
			karbohidrat = request.POST.get('karbohidrat')
			vitamin = request.POST.get('vitamin')
			jumlah_vitamin = request.POST.get('jumlah_vitamin')
			ig = request.POST.get('indeks_glukemik')
			harga = request.POST.get('harga')

			vitamin = str(vitamin.split(',')).replace("'", '"')
			print(vitamin)
			jumlah_vitamin = str([int(x) for x in jumlah_vitamin.split(',')])
			result = process(f"""tambah_makanan('{nama}', {lemak}, {protein}, {karbohidrat}, {vitamin}, {jumlah_vitamin}, {harga}, {ig})""")
			print("ini hasil "+result)
		except:
			context = {'error':'error'}
	return redirect('list_makanan')

def update_makanan(request):
	if request.method == 'POST':
		try:
			result = process('update_makanan(M, L, P, K, V, JV, H, IG)')
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

def search_makanan(request):
	return redirect('list_makanan')

def filter_makanan(request):
	if request.method == 'POST':
		min_harga=request.POST.get('budget')
		min_kalori=request.POST.get('min_kalori')
		maks_kalori=request.POST.get('max_kalor')
		min_lemak=request.POST.get('min_lemak')
		maks_lemak=request.POST.get('maks_lemak')
		min_protein=request.POST.get('min_protein')