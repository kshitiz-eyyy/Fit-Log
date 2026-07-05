import 'dart:async';

abstract class MealTrackerRepo {
  Future<void> saveMealToCloud({
    required String title,
    required int calories,
    required int protein,
    required int carbs,
    required int fats,
  });
}