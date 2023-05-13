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

			vitamin = str(vitamin.split(' ')).replace("'", '"') if vitamin else str([])
			jumlah_vitamin = str([int(x) for x in jumlah_vitamin.split(' ')]) if jumlah_vitamin else str([])
			query = f"""tambah_makanan('{nama}', {lemak}, {protein}, {karbohidrat}, {vitamin}, {jumlah_vitamin}, {harga}, {ig})"""
			print(query)

			result = process(query)
		except:
			context = {'error':'error'}
	return redirect('list_makanan')

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

			vitamin = str(vitamin.split(' ')).replace("'", '"')
			jumlah_vitamin = str([int(x) for x in jumlah_vitamin.split(',')])
			result = process(f"""update_makanan('{nama}', {lemak}, {protein}, {karbohidrat}, {vitamin}, {jumlah_vitamin}, {harga}, {ig})""")
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
				result.append(data[0])
				
			return render(request, 'list_makanan.html', context = {'makanan':result})
		except:
			context = {'error':'error'}
			return HttpResponse('error')
	return redirect('list_makanan')