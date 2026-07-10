import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/dashboard_model.dart';
import 'dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String get _currentUserId => FirebaseAuth.instance.currentUser?.uid ?? "";

  @override
  Future<DashboardStateModel> fetchDashboardMetrics() async {
    if (_currentUserId.isEmpty) return DashboardStateModel.initial();

    final doc = await _firestore.collection('users').doc(_currentUserId).get();
    if (!doc.exists) {
      return DashboardStateModel.initial();
    }

    final data = doc.data() ?? {};

    return DashboardStateModel(
      userName: data['name'] ?? "FitLog Athlete",
      isPremiumUser: data['admin_force_premium'] ?? data['isPremiumUser'] ?? false,
      currentStreak: data['current_streak'] ?? 0,
      personalRecordStreak: data['personalRecordStreak'] ?? 0,
      loggedToday: data['loggedToday'] ?? false,
      internalCaloriesEaten: data['internalCaloriesEaten'] ?? 0,
      currentTargetCalories: data['target_calories'] ?? 2000,
      hydrationAmount: (data['hydrationAmount'] ?? 0.0).toDouble(),
      hydrationGoal: (data['hydration_goal'] ?? 3.5).toDouble(),
      hydrationReminderActive: data['hydrationReminderActive'] ?? false,
      volumeProgress: (data['volumeProgress'] ?? 0.0).toDouble(),
      volumeTarget: (data['volumeTarget'] ?? 1000.0).toDouble(),
      globalChallengeHeadline: data['global_challenge_headline'] ?? "Loading Dynamic Event...",
      isJoinedCommunityChallenge: data['isJoinedCommunityChallenge'] ?? false,
      showSystemNoticeBanner: data['showSystemNoticeBanner'] ?? false,
      systemNoticeAlertText: data['systemNoticeAlertText'] ?? "",
      displayBmiValue: (data['bmi_value'] ?? 0.0).toDouble(),
      bmiStatusText: data['bmi_status'] ?? "Calculating...",
    );
  }

  @override
  Future<void> updateStreakLoggingStatus(bool loggedToday) async {
    await _firestore.collection('users').doc(_currentUserId).update({
      'loggedToday': loggedToday,
    });
  }

  @override
  Future<void> updateHydrationAlertSwitch(bool active) async {
    await _firestore.collection('users').doc(_currentUserId).update({
      'hydrationReminderActive': active,
    });
  }

  @override
  Future<void> updateCommunityChallengeParticipationStatus(bool joined) async {
    await _firestore.collection('users').doc(_currentUserId).update({
      'isJoinedCommunityChallenge': joined,
    });
  }

  @override
  Future<void> updateHydrationLevel(double newLevel) async {
    await _firestore.collection('users').doc(_currentUserId).update({
      'hydrationAmount': newLevel,
    });
  }}