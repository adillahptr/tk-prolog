from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt

from tk_prolog import process

def list_makanan(request):
	result = process('data_makanan(M, L, P, K, V, JV, H, IG, C)')
	for i in range(len(result)):
		result[i]['VJV'] = zip(result[i]['V'], result[i]['JV'])
	return render(request, 'list_makanan.html', context = {'makanan':result})

@csrf_exempt
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

			vitamin = str(vitamin.split(' ')).replace("'", '"') if vitamin else str([])
			jumlah_vitamin = str([int(x) for x in jumlah_vitamin.split(' ')]) if jumlah_vitamin else str([])
			query = f"""tambah_makanan('{nama}', {lemak}, {protein}, {karbohidrat}, {vitamin}, {jumlah_vitamin}, {harga}, {ig})"""

			result = process(query)

			if not result:
				messages.info(request, 'Gagal menambahkan makanan')
		except:
			messages.info(request, 'Gagal menambahkan makanan')
	return redirect('list_makanan')

@csrf_exempt
def update_makanan(request):
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

			vitamin = str(vitamin.split(' ')).replace("'", '"') if vitamin else str([])
			jumlah_vitamin = str([int(x) for x in jumlah_vitamin.split(' ')]) if jumlah_vitamin else str([])
			result = process(f"""update_makanan('{nama}', {lemak}, {protein}, {karbohidrat}, {vitamin}, {jumlah_vitamin}, {harga}, {ig})""")

			if not result:
				messages.info(request, 'Gagal mengupdate makanan')
		except:
			messages.info(request, 'Gagal mengupdate makanan')
	return redirect('list_makanan')

def hapus_makanan(request, nama_makanan):
	try:
		result = process(f"delete_makanan('{nama_makanan}')")
	except:
		messages.info(request, 'Gagal menghapus makanan')
	return redirect('list_makanan')

@csrf_exempt
def search_makanan(request):
	if request.method == 'POST':
		try:
			nama = request.POST.get('nama_makanan')
			min_harga = request.POST.get('min_harga')
			max_harga = request.POST.get('max_harga')
			min_kalori = request.POST.get('min_kalori')
			max_kalori = request.POST.get('max_kalori') 
			min_lemak = request.POST.get('min_lemak')
			max_lemak = request.POST.get('max_lemak') 
			min_protein = request.POST.get('min_protein')
			max_protein = request.POST.get('max_protein') 
			min_karbohidrat = request.POST.get('min_karbohidrat')
			max_karbohidrat = request.POST.get('max_karbohidrat') 
			vitamin = request.POST.get('vitamin')
			min_ig = request.POST.get('min_ig')
			max_ig = request.POST.get('max_ig') 

			vitamin = str(vitamin.split(' ')).replace("'", '"') if vitamin else str([])
			nama = f"'{nama}'" if nama else "''"

			query = f"""filter_makanan(M, {nama}, {min_harga}, {max_harga if max_harga else 'none'}, {min_kalori}, {max_kalori if max_kalori else 'none'}, {min_lemak}, {max_lemak if max_lemak else 'none'}, {min_protein}, {max_protein if max_protein else 'none'}, {min_karbohidrat}, {max_karbohidrat if max_karbohidrat else 'none'}, {min_ig}, {max_ig if max_ig else 'none'}, {vitamin})"""
			
			filtered_makanan = process(query)

			result = []

			for m in filtered_makanan:
				data = process(f"data_makanan('{m['M']}', L, P, K, V, JV, H, IG, C)")
				data[0]['M'] = m['M']
				data[0]['VJV'] = zip(data[0]['V'], data[0]['JV'])
				result.append(data[0])

			return render(request, 'list_makanan.html', context = {'makanan':result})
		except:
			messages.info(request, 'Terjadi kesalahan')
	return redirect('list_makanan')