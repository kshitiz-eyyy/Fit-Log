class SleepData {
  final double lastNightHours;
  final List<double> weeklyHistory;
  final bool isCurrentlyAsleep;
  final bool isAutoTrackingActive;
  final bool sleepMode;

  SleepData({
    required this.lastNightHours,
    required this.weeklyHistory,
    required this.isCurrentlyAsleep,
    required this.isAutoTrackingActive,
    required this.sleepMode,
  });

  SleepData copyWith({
    double? lastNightHours,
    List<double>? weeklyHistory,
    bool? isCurrentlyAsleep,
    bool? isAutoTrackingActive,
    bool? sleepMode,
  }) {
    return SleepData(
      lastNightHours: lastNightHours ?? this.lastNightHours,
      weeklyHistory: weeklyHistory ?? this.weeklyHistory,
      isCurrentlyAsleep: isCurrentlyAsleep ?? this.isCurrentlyAsleep,
      isAutoTrackingActive: isAutoTrackingActive ?? this.isAutoTrackingActive,
      sleepMode: sleepMode ?? this.sleepMode,
    );
  }
}
