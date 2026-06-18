import 'package:flutter/material.dart';

import '../repo/meal_tracker_repo.dart';

class MealTrackingViewModel extends ChangeNotifier {
  final MealTrackerRepo _mealRepo;

  MealTrackingViewModel({required MealTrackerRepo mealRepo}) : _mealRepo = mealRepo;

  Future<void> logUserMeal({
    required String name,
    required int cals,
    required int p,
    required int c,
    required int f,
  }) async {
    await _mealRepo.saveMealToCloud(
      title: name,
      calories: cals,
      protein: p,
      carbs: c,
      fats: f,
    );

    notifyListeners();
  }
}