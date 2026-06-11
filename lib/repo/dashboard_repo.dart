import '../model/dashboard_model.dart';

abstract class DashboardRepo {
  Future<DashboardStateModel> fetchDashboardMetrics();
  Future<void> updateStreakLoggingStatus(bool completed);
  Future<void> updateHydrationLevel(double incrementLitres);
  Future<void> updateHydrationAlertSwitch(bool active);
  Future<void> updateCommunityChallengeParticipationStatus(bool joined);
}