import 'package:flutter/material.dart';
import '../repo/performance_repo.dart';
import '../repo/performance_repo_impl.dart';

class PerformanceViewModel extends ChangeNotifier {
  final PerformanceRepo _repo;

  DateTime _selectedDate = DateTime.now();
  Map<DateTime, int> _activityCounts = {};
  bool _isLoading = true;
  String? _errorMessage;

  PerformanceViewModel({PerformanceRepo? repo})
      : _repo = repo ?? PerformanceRepoImpl() {
    loadHeatmap();
  }

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, int> get activityCounts => _activityCounts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<DateTime> get heatmapDates {
    if (_activityCounts.isEmpty) return [];
    final sorted = _activityCounts.keys.toList()..sort();
    return sorted;
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> loadHeatmap() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _activityCounts = await _repo.fetchActivityHeatmap();
    } catch (e) {
      _errorMessage = e.toString();
      _activityCounts = {};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Color heatColorForCount(int count, {required Color neonAccent}) {
    if (count == 0) return Colors.white10;
    if (count == 1) return neonAccent.withValues(alpha: 0.25);
    if (count == 2) return neonAccent.withValues(alpha: 0.55);
    return neonAccent;
  }
}
