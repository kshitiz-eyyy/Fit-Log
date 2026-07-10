import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardStateModel {
  final String userName;
  final bool isPremiumUser;
  final int currentStreak;
  final int personalRecordStreak;
  final bool loggedToday;
  final int internalCaloriesEaten;
  final int currentTargetCalories;
  final double hydrationAmount;
  final double hydrationGoal;
  final bool hydrationReminderActive;
  final double volumeProgress;
  final double volumeTarget;
  final String globalChallengeHeadline;
  final bool isJoinedCommunityChallenge;
  final bool showSystemNoticeBanner;
  final String systemNoticeAlertText;
  final double displayBmiValue;
  final String bmiStatusText;

  DashboardStateModel({
    required this.userName,
    required this.isPremiumUser,
    required this.currentStreak,
    required this.personalRecordStreak,
    required this.loggedToday,
    required this.internalCaloriesEaten,
    required this.currentTargetCalories,
    required this.hydrationAmount,
    required this.hydrationGoal,
    required this.hydrationReminderActive,
    required this.volumeProgress,
    required this.volumeTarget,
    required this.globalChallengeHeadline,
    required this.isJoinedCommunityChallenge,
    required this.showSystemNoticeBanner,
    required this.systemNoticeAlertText,
    required this.displayBmiValue,
    required this.bmiStatusText,
  });

  factory DashboardStateModel.initial() {
    return DashboardStateModel(
      userName: "FitLog Athlete",
      isPremiumUser: false,
      currentStreak: 0,
      personalRecordStreak: 0,
      loggedToday: false,
      internalCaloriesEaten: 0,
      currentTargetCalories: 2000,
      hydrationAmount: 0.0,
      hydrationGoal: 3.5,
      hydrationReminderActive: false,
      volumeProgress: 0.0,
      volumeTarget: 1000.0,
      globalChallengeHeadline: "Loading Dynamic Event...",
      isJoinedCommunityChallenge: false,
      showSystemNoticeBanner: false,
      systemNoticeAlertText: "",
      displayBmiValue: 0.0,
      bmiStatusText: "Calculating...",
    );
  }
}
