from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse

from tk_prolog import process

def index(request):
	x = process('data_makanan(M, L, P, K, V, JV, H, IG, C)')
	return HttpResponse(x)
