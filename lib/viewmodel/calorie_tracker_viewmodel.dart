import 'package:flutter/material.dart';
import '../model/meal_model.dart';
import '../repo/calorie_repository.dart';

class CalorieTrackerViewModel extends ChangeNotifier {
  final ICalorieRepository _repository;

  CalorieTrackerViewModel(this._repository) {
    fetchMeals();
  }

  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int get totalCalories => _meals.fold(0, (sum, meal) => sum + meal.calories);
  final int goalCalories = 2000;

  Future<void> fetchMeals() async {
    _isLoading = true;
    notifyListeners();

    _meals = await _repository.getMeals();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateMealCalories(String name, int calories) async {
    final index = _meals.indexWhere((m) => m.name == name);
    if (index != -1) {
      _meals[index] = _meals[index].copyWith(calories: calories);
    } else {
      _meals.add(Meal(name: name, calories: calories));
    }
    notifyListeners();
    await _repository.saveMeals(_meals);
  }

  Future<void> addMeal(String name, int calories) async {
    _meals.add(Meal(name: name, calories: calories));
    notifyListeners();
    await _repository.saveMeals(_meals);
  }
}
