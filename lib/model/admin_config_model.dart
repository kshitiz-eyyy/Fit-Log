class AdminConfigModel {
  final String globalChallengeName;
  final String systemNoticeText;
  final bool forcePremiumToAll;
  final bool enableVideoTutorials;
  final bool enableTrainingSplits;
  final bool showSystemNoticeAlert;
  final List<String> injectedExercisesList;
  final int simulatedUserCount;

  AdminConfigModel({
    required this.globalChallengeName,
    required this.systemNoticeText,
    required this.forcePremiumToAll,
    required this.enableVideoTutorials,
    required this.enableTrainingSplits,
    required this.showSystemNoticeAlert,
    required this.injectedExercisesList,
    this.simulatedUserCount = 1248,
  });

  factory AdminConfigModel.initial() {
    return AdminConfigModel(
      globalChallengeName: "Solstice 100k Squat Blast",
      systemNoticeText: "Scheduled backend database sync at midnight.",
      forcePremiumToAll: false,
      enableVideoTutorials: true,
      enableTrainingSplits: true,
      showSystemNoticeAlert: false,
      injectedExercisesList: [],
    );
  }

  AdminConfigModel copyWith({
    String? globalChallengeName,
    String? systemNoticeText,
    bool? forcePremiumToAll,
    bool? enableVideoTutorials,
    bool? enableTrainingSplits,
    bool? showSystemNoticeAlert,
    List<String>? injectedExercisesList,
  }) {
    return AdminConfigModel(
      globalChallengeName: globalChallengeName ?? this.globalChallengeName,
      systemNoticeText: systemNoticeText ?? this.systemNoticeText,
      forcePremiumToAll: forcePremiumToAll ?? this.forcePremiumToAll,
      enableVideoTutorials: enableVideoTutorials ?? this.enableVideoTutorials,
      enableTrainingSplits: enableTrainingSplits ?? this.enableTrainingSplits,
      showSystemNoticeAlert: showSystemNoticeAlert ?? this.showSystemNoticeAlert,
      injectedExercisesList: injectedExercisesList ?? this.injectedExercisesList,
      simulatedUserCount: this.simulatedUserCount,
    );
  }
}