import 'package:flutter/material.dart';

import '../model/water_log_model.dart';
import '../repo/water_repository.dart';


class WaterTrackerViewModel extends ChangeNotifier {
  final WaterRepository _repository;

  WaterTrackerViewModel({required WaterRepository repository}) : _repository = repository {
    _loadInitialData();
  }

  // --- STATE VARIABLES ---
  double _currentIntake = 2.4;
  final double _goal = 3.5;
  bool _remindersEnabled = true;
  String _frequency = "Every 1 hour";
  List<WaterLogItem> _logs = [];
  bool _isLoading = true;

  // --- GETTERS ---
  double get currentIntake => _currentIntake;
  double get goal => _goal;
  bool get remindersEnabled => _remindersEnabled;
  String get frequency => _frequency;
  List<WaterLogItem> get logs => _logs;
  bool get isLoading => _isLoading;

  // --- ACTIONS & BUSINESS LOGIC ---
  Future<void> _loadInitialData() async {
    _logs = await _repository.fetchHydrationLogs();
    _isLoading = false;
    notifyListeners();
  }

  void addWater(double amount, {String title = 'Water Intake'}) {
    // 1. Update cumulative volume metrics
    _currentIntake = (_currentIntake + amount).clamp(0.0, 9.9);

    // 2. Format a dynamic history log item entry based on modern device timestamp rules
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final timestamp = "$hour:$minute $period";

    final newLog = WaterLogItem(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      time: timestamp,
      amountString: "${(amount.abs() * 1000).toInt()}ml",
      amountLiters: amount,
      accentColor: amount >= 0 ? const Color(0xFF00E5FF) : const Color(0xFFFF6D00),
    );

    // 3. Update the data layer and UI state tree
    _logs.insert(0, newLog);
    _repository.saveLogItem(newLog);

    notifyListeners();
  }

  void toggleReminders(bool value) {
    _remindersEnabled = value;
    notifyListeners();
  }

  void updateFrequency(String freshFrequency) {
    _frequency = freshFrequency;
    notifyListeners();
  }
}