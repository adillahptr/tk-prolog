from django.urls import path
from .views import meal_planner


urlpatterns = [
	path('', meal_planner, name='meal_planner'),
]