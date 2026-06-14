import 'dart:async';

abstract class WorkoutRepo {
  Future<void> saveWorkoutToCloud({
    required String title,
    required String subtitle,
    required String metric,
  });
}