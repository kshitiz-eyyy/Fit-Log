import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sensors_plus/sensors_plus.dart';

abstract class SleepRepository {
  Stream<AccelerometerEvent> get accelerometerStream;
  Future<List<double>> getWeeklyHistory();
  Future<double> getLastSleepSession();
  Future<void> saveSleepSession(double hours);
}

class SleepRepositoryImpl implements SleepRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<AccelerometerEvent> get accelerometerStream => accelerometerEvents;

  @override
  Future<double> getLastSleepSession() async {
    final user = _auth.currentUser;
    if (user == null) return 0.0;

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sleep_sessions')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return (snapshot.docs.first.data()['hours'] as num).toDouble();
      }
    } catch (e) {
      print("Error fetching last sleep session: $e");
    }
    return 0.0;
  }

  @override
  Future<List<double>> getWeeklyHistory() async {
    final user = _auth.currentUser;
    if (user == null) return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

    try {
      final now = DateTime.now();
      final sevenDaysAgo = now.subtract(const Duration(days: 7));

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sleep_sessions')
          .where('timestamp', isGreaterThan: Timestamp.fromDate(sevenDaysAgo))
          .orderBy('timestamp', descending: true)
          .get();

      // Initialize with 0.0 for 7 days
      List<double> history = List.filled(7, 0.0);
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final timestamp = (data['timestamp'] as Timestamp).toDate();
        final hours = (data['hours'] as num).toDouble();
        
        // Find the index (0 for today, 1 for yesterday, etc.)
        int difference = now.difference(timestamp).inDays;
        if (difference >= 0 && difference < 7) {
          // Store progress (hours / 8.0) as requested by the UI logic
          // Map to M, T, W, T, F, S, S index
          int dayOfWeek = (timestamp.weekday - 1) % 7;
          history[dayOfWeek] = (hours / 8.0).clamp(0.0, 1.0);
        }
      }
      return history;
    } catch (e) {
      print("Error fetching sleep history: $e");
      return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    }
  }

  @override
  Future<void> saveSleepSession(double hours) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sleep_sessions')
          .add({
        'hours': hours,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving sleep session: $e");
    }
  }
}
