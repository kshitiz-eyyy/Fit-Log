import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/activity_model.dart';
import '../model/daily_chart_data.dart';
import 'activity_repo.dart';

class ActivityRepoImpl implements ActivityRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _currentUserId = "Eb3LsmAGcqNpd5pfwO28TpPyFn33";

  @override
  Future<ActivityStateModel> loadCombinedActivityHistory() async {
    final userDoc = await _firestore.collection('users').doc(_currentUserId).get();
    final targetCalories = userDoc.data()?['target_calories'] as int? ?? 2500;

    List<Map<String, dynamic>> resolvedLogs = [];
    List<DailyChartData> chartDataTemp = [];
    DateTime today = DateTime.now();

    DateTime sevenDaysAgo = today.subtract(const Duration(days: 7));

    final logsSnapshot = await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('activity_logs')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgo))
        .orderBy('timestamp', descending: true)
        .get();

    Map<String, int> calorieTracker = {};
    for (int i = 6; i >= 0; i--) {
      DateTime checkDate = today.subtract(Duration(days: i));
      String dateKey = "${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}";
      calorieTracker[dateKey] = 0;
    }

    for (var doc in logsSnapshot.docs) {
      final data = doc.data();
      final String logId = doc.id;
      final String type = data['type'] ?? 'TRAINING';
      final Timestamp? timestamp = data['timestamp'] as Timestamp?;

      final DateTime logDateTime = timestamp != null ? timestamp.toDate() : DateTime.now();

      String dateKey = "${logDateTime.year}-${logDateTime.month.toString().padLeft(2, '0')}-${logDateTime.day.toString().padLeft(2, '0')}";

      if (type == "NUTRITION") {
        int mealCalories = data['calories'] as int? ?? 0;
        if (calorieTracker.containsKey(dateKey)) {
          calorieTracker[dateKey] = calorieTracker[dateKey]! + mealCalories;
        }

        resolvedLogs.add({
          "id": logId,
          "type": "NUTRITION",
          "time": _formatLogTime(logDateTime),
          "title": data['title'] ?? 'Meal Log',
          "subtitle": "Macros: P: ${data['protein']}g • C: ${data['carbs']}g • F: ${data['fats']}g",
          "metric": "$mealCalories kcal",
          "icon": Icons.restaurant,
          "iconColor": Colors.orangeAccent,
          "tag": _isSameDay(logDateTime, today) ? "TODAY" : "PAST LOG",
          "showTag": true,
        });
      } else if (type == "TRAINING") {
        resolvedLogs.add({
          "id": logId,
          "type": "TRAINING",
          "time": _formatLogTime(logDateTime),
          "title": data['title'] ?? 'Workout',
          "subtitle": data['subtitle'] ?? 'Tracked Performance Log',
          "metric": data['metric'] ?? '',
          "icon": Icons.fitness_center,
          "iconColor": const Color(0xFFCCFF00),
          "tag": _isSameDay(logDateTime, today) ? "TODAY" : "COMPLETED",
          "showTag": true,
        });
      }
    }

    for (int i = 6; i >= 0; i--) {
      DateTime checkDate = today.subtract(Duration(days: i));
      String dateKey = "${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}";

      String dayLabel = _getDayLabel(checkDate.weekday);
      if (i == 0) dayLabel = "TODAY";

      chartDataTemp.add(DailyChartData(
        label: dayLabel,
        calories: calorieTracker[dateKey] ?? 0,
        isToday: i == 0,
      ));
    }

    return ActivityStateModel(
      targetCaloriesWeeklyBaseline: targetCalories,
      allActivities: resolvedLogs,
      weeklyChartData: chartDataTemp,
    );
  }

  @override
  Future<void> deleteLogItem(Map<String, dynamic> item) async {
    String docId = item["id"];
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('activity_logs')
        .doc(docId)
        .delete();
  }

  String _formatLogTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2,'0')}-${dt.day.toString().padLeft(2,'0')} • ${dt.hour}:${dt.minute.toString().padLeft(2,'0')}";
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _getDayLabel(int weekday) {
    switch (weekday) {
      case 1: return "MON";
      case 2: return "TUE";
      case 3: return "WED";
      case 4: return "THU";
      case 5: return "FRI";
      case 6: return "SAT";
      case 7: return "SUN";
      default: return "";
    }
  }
}