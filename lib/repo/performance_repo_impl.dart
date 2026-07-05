import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/firebase_user_helper.dart';
import 'performance_repo.dart';

class PerformanceRepoImpl implements PerformanceRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<DateTime, int>> fetchActivityHeatmap({int days = 35}) async {
    final userId = FirebaseUserHelper.currentUserId;
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day)
        .subtract(Duration(days: days - 1));

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activity_logs')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    final Map<String, int> countsByDate = {};
    for (int i = 0; i < days; i++) {
      final date = startDate.add(Duration(days: i));
      final key = _dateKey(date);
      countsByDate[key] = 0;
    }

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final timestamp = data['timestamp'];
      if (timestamp is! Timestamp) continue;

      final logDate = timestamp.toDate();
      final key = _dateKey(logDate);
      if (countsByDate.containsKey(key)) {
        countsByDate[key] = (countsByDate[key] ?? 0) + 1;
      }
    }

    return Map.fromEntries(
      countsByDate.entries.map(
        (entry) => MapEntry(_parseDateKey(entry.key), entry.value),
      ),
    );
  }

  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  DateTime _parseDateKey(String key) {
    final parts = key.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }
}
