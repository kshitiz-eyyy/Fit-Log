import 'package:cloud_firestore/cloud_firestore.dart';
import 'workout_repo.dart';

class WorkoutRepoImpl implements WorkoutRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _currentUserId = "Eb3LsmAGcqNpd5pfwO28TpPyFn33";

  @override
  Future<void> saveWorkoutToCloud({
    required String title,
    required String subtitle,
    required String metric,
  }) async {
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('activity_logs')
        .add({
      'type': 'TRAINING',
      'title': title,
      'subtitle': subtitle,
      'metric': metric,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}