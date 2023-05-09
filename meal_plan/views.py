from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from meal_plan import process

from pyswip import Prolog

def index(request):
	x = process('get_data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return HttpResponse(x)

def list_makanan(request):
	result = process('get_data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return render(request, 'list_makanan.html', context = {'makanan':result})


	