from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.contrib import messages

from tk_prolog import process



def meal_planner(request):
	if request.method == 'POST':
		try:
			amount = request.POST.get('amount')
			budget = request.POST.get('budget')
			min_kalori = request.POST.get('min_kalori')
			max_kalori = request.POST.get('max_kalori') 
			min_lemak = request.POST.get('min_lemak')
			max_lemak = request.POST.get('max_lemak') 
			min_protein = request.POST.get('min_protein')
			max_ig = request.POST.get('max_ig') 

			query = f"""menu_plan({max_ig if max_ig else 'none'}, {amount}, {budget}, {min_kalori}, {max_kalori if max_kalori else 'none'}, {min_lemak}, {max_lemak if max_lemak else 'none'}, {min_protein}, X, Tot_price, Tot_kalori, Tot_lemak, Tot_protein)"""
			
			result = process(query)

			if not result:
				raise Exception("")

			for i in range(len(result)):
				for j in range(len(result[i]['X'])):
					nama = result[i]['X'][j]
					data = process(f"data_makanan('{nama}', L, P, K, V, JV, H, IG, C)")
					result[i]['X'][j] = data[0]
					data[0]['M'] = nama
					data[0]['VJV'] = zip(data[0]['V'], data[0]['JV'])
			return render(request, 'meal_planner.html', context = {'plan':result})
		except:
			messages.info(request, 'Gagal membuat meal plan')
	return render(request, 'meal_planner.html')
