import 'dart:async';
import 'package:flutter/material.dart';
import '../model/sleep_data.dart';
import '../repo/sleep_repository.dart';

class SleepViewModel extends ChangeNotifier {
  final SleepRepository _repository;

  SleepData _data = SleepData(
    lastNightHours: 7.2,
    weeklyHistory: [0.75, 0.5, 0.65, 0.8, 0.55, 0.9, 0.4],
    isCurrentlyAsleep: false,
    isAutoTrackingActive: true,
    sleepMode: true,
  );

  SleepData get data => _data;

  double _currentAcceleration = 0.0;
  double get currentAcceleration => _currentAcceleration;

  StreamSubscription? _sensorSubscription;
  DateTime _lastSignificantMovement = DateTime.now();
  DateTime? _autoSleepStartTime;

  // Constants
  static const double _movementThreshold = 0.5;
  static const Duration _stillnessNeededForSleep = Duration(minutes: 10);

  SleepViewModel({required SleepRepository repository}) : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    final history = await _repository.getWeeklyHistory();
    _data = _data.copyWith(weeklyHistory: history);
    if (_data.isAutoTrackingActive) {
      startTracking();
    }
    notifyListeners();
  }

  void startTracking() {
    _sensorSubscription?.cancel();
    _sensorSubscription = _repository.accelerometerStream.listen((event) {
      final double acceleration = (event.x.abs() + event.y.abs() + (event.z.abs() - 9.81).abs());
      _currentAcceleration = acceleration;

      if (acceleration > _movementThreshold) {
        _handleMovementDetected();
      } else {
        _checkStillnessForSleep();
      }
      notifyListeners();
    });
    _data = _data.copyWith(isAutoTrackingActive: true);
    notifyListeners();
  }

  void stopTracking() {
    _sensorSubscription?.cancel();
    _sensorSubscription = null;
    _data = _data.copyWith(isAutoTrackingActive: false, isCurrentlyAsleep: false);
    notifyListeners();
  }

  void toggleSleepMode(bool value) {
    _data = _data.copyWith(sleepMode: value);
    notifyListeners();
  }

  void _handleMovementDetected() {
    final now = DateTime.now();
    _lastSignificantMovement = now;

    if (_data.isCurrentlyAsleep) {
      _data = _data.copyWith(isCurrentlyAsleep: false);
      if (_autoSleepStartTime != null) {
        final duration = now.difference(_autoSleepStartTime!);
        final hours = duration.inMinutes / 60.0;
        
        _data = _data.copyWith(lastNightHours: double.parse(hours.toStringAsFixed(1)));
        
        // Update history
        final newHistory = List<double>.from(_data.weeklyHistory);
        int todayIndex = (now.weekday - 1) % 7;
        newHistory[todayIndex] = (hours / 8.0).clamp(0.0, 1.0);
        _data = _data.copyWith(weeklyHistory: newHistory);
        
        _repository.saveSleepSession(hours);
      }
    }
  }

  void _checkStillnessForSleep() {
    if (_data.isCurrentlyAsleep) return;

    final now = DateTime.now();
    final timeSinceMovement = now.difference(_lastSignificantMovement);

    // Criteria: If phone is still for 10 mins and it's typical sleep time (e.g., 9 PM - 9 AM)
    bool isSleepTime = now.hour >= 21 || now.hour <= 9;

    if (timeSinceMovement > _stillnessNeededForSleep && isSleepTime) {
      _data = _data.copyWith(isCurrentlyAsleep: true);
      _autoSleepStartTime = _lastSignificantMovement;
    }
  }

  @override
  void dispose() {
    _sensorSubscription?.cancel();
    super.dispose();
  }
}
