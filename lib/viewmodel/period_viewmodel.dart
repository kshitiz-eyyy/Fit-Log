import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repo/period_repository.dart';
import '../repository/period_repository.dart';

class PeriodViewModel extends ChangeNotifier {
  final PeriodRepository _repo = PeriodRepository();

  DateTime currentDate = DateTime(2026, 7, 1);
  int dayCount = 12;
  late List<List<int>> heatmapData;

  PeriodViewModel() {
    heatmapData = _repo.fetchHeatmapData();
  }

  void nextDay() {
    currentDate = currentDate.add(const Duration(days: 1));
    dayCount++;
    notifyListeners();
  }

  void previousDay() {
    currentDate = currentDate.subtract(const Duration(days: 1));
    dayCount = dayCount > 1 ? dayCount - 1 : 1;
    notifyListeners();
  }

  String get formattedDate => DateFormat('MMMM d, yyyy').format(currentDate);

  Color getHeatmapColor(int value) {
    switch (value) {
      case 0:
        return Colors.green.shade200;
      case 1:
        return Colors.green.shade400;
      case 2:
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }
}
