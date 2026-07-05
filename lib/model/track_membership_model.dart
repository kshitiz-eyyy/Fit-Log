class TrackMembershipModel {
  int daysRemaining;
  int totalDays;
  DateTime cycleResetDate;

  TrackMembershipModel({
    required this.daysRemaining,
    required this.totalDays,
    required this.cycleResetDate,
  });

  double get progress => daysRemaining / totalDays;
}