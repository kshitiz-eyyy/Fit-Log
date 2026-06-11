import 'package:cloud_firestore/cloud_firestore.dart';
import 'meal_tracker_repo.dart';

class MealTrackerRepoImpl implements MealTrackerRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _currentUserId = "Eb3LsmAGcqNpd5pfwO28TpPyFn33";

  @override
  Future<void> saveMealToCloud({
    required String title,
    required int calories,
    required int protein,
    required int carbs,
    required int fats
  }) async {
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('activity_logs')
        .add({
      'type': 'NUTRITION',
      'title': title,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}