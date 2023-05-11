from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse

from tk_prolog import process

def index(request):
	return render(request, 'meal_planner.html')
