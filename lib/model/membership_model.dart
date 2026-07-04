import 'package:cloud_firestore/cloud_firestore.dart';

class MembershipModel {
  final String planName;
  final String planSubtitle;
  final int daysRemaining;
  final int totalDays;
  final DateTime cycleResetDate;
  final String tier;
  final bool isActive;
  final double monthlyPrice;

  MembershipModel({
    required this.planName,
    required this.planSubtitle,
    required this.daysRemaining,
    required this.totalDays,
    required this.cycleResetDate,
    required this.tier,
    required this.isActive,
    required this.monthlyPrice,
  });

  double get progress => totalDays > 0 ? daysRemaining / totalDays : 0;

  factory MembershipModel.defaults() {
    final resetDate = DateTime.now().add(const Duration(days: 30));
    return MembershipModel(
      planName: 'Standard Track',
      planSubtitle: 'Full Access Tracker',
      daysRemaining: 30,
      totalDays: 30,
      cycleResetDate: resetDate,
      tier: 'PREMIUM PRO',
      isActive: true,
      monthlyPrice: 29.99,
    );
  }

  factory MembershipModel.fromMap(Map<String, dynamic> data) {
    final resetTimestamp = data['cycleResetDate'];
    DateTime resetDate;
    if (resetTimestamp is Timestamp) {
      resetDate = resetTimestamp.toDate();
    } else {
      resetDate = DateTime.now().add(const Duration(days: 30));
    }

    return MembershipModel(
      planName: data['planName'] as String? ?? 'Standard Track',
      planSubtitle: data['planSubtitle'] as String? ?? 'Full Access Tracker',
      daysRemaining: data['daysRemaining'] as int? ?? 30,
      totalDays: data['totalDays'] as int? ?? 30,
      cycleResetDate: resetDate,
      tier: data['tier'] as String? ?? 'PREMIUM PRO',
      isActive: data['isActive'] as bool? ?? true,
      monthlyPrice: (data['monthlyPrice'] as num?)?.toDouble() ?? 29.99,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'planName': planName,
      'planSubtitle': planSubtitle,
      'daysRemaining': daysRemaining,
      'totalDays': totalDays,
      'cycleResetDate': Timestamp.fromDate(cycleResetDate),
      'tier': tier,
      'isActive': isActive,
      'monthlyPrice': monthlyPrice,
    };
  }

  MembershipModel copyWith({
    String? planName,
    String? planSubtitle,
    int? daysRemaining,
    int? totalDays,
    DateTime? cycleResetDate,
    String? tier,
    bool? isActive,
    double? monthlyPrice,
  }) {
    return MembershipModel(
      planName: planName ?? this.planName,
      planSubtitle: planSubtitle ?? this.planSubtitle,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      totalDays: totalDays ?? this.totalDays,
      cycleResetDate: cycleResetDate ?? this.cycleResetDate,
      tier: tier ?? this.tier,
      isActive: isActive ?? this.isActive,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
    );
  }
}
