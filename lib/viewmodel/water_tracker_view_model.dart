import 'package:flutter/material.dart';

import '../model/water_log_model.dart';
import '../repo/water_repository.dart';


class WaterTrackerViewModel extends ChangeNotifier {
  final WaterRepository _repository;
  final String userId;

  WaterTrackerViewModel({
    required WaterRepository repository,
    required this.userId,
  }) : _repository = repository {
    loadUserConfiguration();
  }

  // --- LOCAL STATES ---
  double _currentIntake = 0.0;
  double _goal = 3.5;
  bool _isLoadingConfig = true;
  bool _remindersEnabled = false;
  String _frequency = "Every 1 hour";
  final List<WaterLogItem> _logs = [];

  // --- GETTERS ---
  double get currentIntake => _currentIntake;
  double get goal => _goal;
  bool get isLoadingConfig => _isLoadingConfig;
  bool get remindersEnabled => _remindersEnabled;
  String get frequency => _frequency;
  List<WaterLogItem> get logs => _logs;

  // --- LIFECYCLE ---
  Future<void> loadUserConfiguration() async {
    if (userId.isEmpty) {
      _isLoadingConfig = false;
      notifyListeners();
      return;
    }

    _isLoadingConfig = true;
    notifyListeners();

    WaterConfig config = await _repository.fetchUserWaterConfig(userId);
    _goal = config.dailyGoal;
    _remindersEnabled = config.isReminderActive;
    _frequency = config.frequency;

    _isLoadingConfig = false;
    notifyListeners();
  }

  Future<void> addWater(double amount, {String title = 'Water Intake'}) async {
    _currentIntake = (_currentIntake + amount).clamp(0.0, 9.9);

    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    _logs.insert(
      0,
      WaterLogItem(
        id: now.millisecondsSinceEpoch.toString(),
        title: title,
        time: "$hour:$minute $period",
        amountString: "${(amount.abs() * 1000).toInt()}ml",
        amountLiters: amount,
        accentColor: amount >= 0 ? const Color(0xFF00E5FF) : const Color(0xFFFF6D00),
      ),
    );
    notifyListeners();

    // Persists target numbers up to the current authenticated user profile
    await _repository.updateUserCurrentIntake(userId, _currentIntake);
  }

  Future<void> toggleReminders(bool value) async {
    _remindersEnabled = value;
    notifyListeners();
    await _repository.updateUserReminderSetting(userId, value);
  }

  Future<void> updateFrequency(String freshFrequency) async {
    _frequency = freshFrequency;
    notifyListeners();

    // Updates local layout and pushes the value to your Firestore document
    await _repository.updateUserFrequencySetting(userId, freshFrequency);
  }
}