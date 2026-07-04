import 'package:flutter/material.dart';
import '../model/dashboard_model.dart';
import '../repo/dashboard_repo.dart';

class DashboardViewModel extends ChangeNotifier {
  final DashboardRepo _repository;

  DashboardStateModel _state = DashboardStateModel.initial();
  bool _isLoading = true;
  int _currentNavigationIndex = 0;
  int _previousNavigationIndex = 0;
  final String _currentQuote =
      "Consistency guarantees elite performance output.";

  DashboardViewModel({required DashboardRepo repository})
    : _repository = repository {
    loadDashboardState();
  }

  DashboardStateModel get state => _state;
  bool get isLoading => _isLoading;
  int get currentNavigationIndex => _currentNavigationIndex;
  int get previousNavigationIndex => _previousNavigationIndex;
  String get currentQuote => _currentQuote;

  Future<void> loadDashboardState() async {
    try {
      _state = await _repository.fetchDashboardMetrics();
    } catch (e) {
      debugPrint("Error updating dashboard data pipeline: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateNavigationIndex(int index) {
    if (index == _currentNavigationIndex) return;
    _previousNavigationIndex = _currentNavigationIndex;
    _currentNavigationIndex = index;
    notifyListeners();
  }

  void returnToPreviousNavigationIndex() {
    final targetIndex = _previousNavigationIndex == _currentNavigationIndex
        ? 0
        : _previousNavigationIndex;
    updateNavigationIndex(targetIndex);
  }

  Future<void> toggleDailyStreakLog() async {
    bool newStatus = !_state.loggedToday;
    await _repository.updateStreakLoggingStatus(newStatus);
    await loadDashboardState();
  }

  Future<void> toggleHydrationRadarAlerts(bool active) async {
    await _repository.updateHydrationAlertSwitch(active);
    await loadDashboardState();
  }

  Future<void> toggleCommunityChallengeParticipation() async {
    bool newStatus = !_state.isJoinedCommunityChallenge;
    await _repository.updateCommunityChallengeParticipationStatus(newStatus);
    await loadDashboardState();
  }

  Future<void> executeSignOutSession() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
