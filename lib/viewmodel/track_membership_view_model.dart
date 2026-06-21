import 'package:flutter/material.dart';

import '../model/track_membership_model.dart';

class TrackMembershipViewModel extends ChangeNotifier {
  late TrackMembershipModel _model;

  TrackMembershipViewModel() {
    _model = TrackMembershipModel(
      daysRemaining: 24,
      totalDays: 30,
      cycleResetDate: DateTime.now().add(const Duration(days: 24)),
    );
  }

  // Getters to expose data safely to the View
  int get daysRemaining => _model.daysRemaining;
  int get totalDays => _model.totalDays;
  double get progress => _model.progress;
  DateTime get cycleResetDate => _model.cycleResetDate;

  // Button Action 1: Simulates refreshing or starting a brand new cycle
  void refreshCycle() {
    _model.daysRemaining = _model.totalDays;
    _model.cycleResetDate = DateTime.now().add(Duration(days: _model.totalDays));

    // Notifies the UI to rebuild with the new values
    notifyListeners();
  }

  // Button Action 2: Resets progress back to zero
  void resetProgressData() {
    _model.daysRemaining = 0;
    _model.cycleResetDate = DateTime.now();

    notifyListeners();
  }
}