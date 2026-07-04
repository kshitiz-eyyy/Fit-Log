import 'package:flutter/material.dart';

import '../model/activity_model.dart';
import '../repo/activity_repo.dart';


class ActivityViewModel extends ChangeNotifier {
  final ActivityRepo _repository;

  ActivityViewModel({required ActivityRepo repository}) : _repository = repository {
    syncActivityHistoryLog();
  }

  ActivityStateModel _state = ActivityStateModel.initial();
  ActivityStateModel get state => _state;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _selectedFilter = "ALL";
  String get selectedFilter => _selectedFilter;

  void updateSelectedFilter(String value) {
    _selectedFilter = value;
    notifyListeners();
  }

  Future<void> syncActivityHistoryLog() async {
    _isLoading = true;
    notifyListeners();

    _state = await _repository.loadCombinedActivityHistory();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeActivityItem(Map<String, dynamic> item) async {
    if (item["isMock"] == true) {
      final updatedList = List<Map<String, dynamic>>.from(_state.allActivities)
        ..removeWhere((element) => element["id"] == item["id"]);
      _state = _state.copyWith(allActivities: updatedList);
      notifyListeners();
      return;
    }

    await _repository.deleteLogItem(item);
    _state = await _repository.loadCombinedActivityHistory();
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredActivities {
    if (_selectedFilter == "ALL") return _state.allActivities;
    return _state.allActivities.where((item) => item["type"] == _selectedFilter).toList();
  }

  int get totalWeeklyCaloriesCalculated {
    return _state.weeklyChartData.map((e) => e.calories).fold(0, (prev, element) => prev + element);
  }
}