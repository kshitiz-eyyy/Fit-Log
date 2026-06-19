import 'package:flutter/material.dart';

class WaterConfig {
  final double dailyGoal;
  final bool isReminderActive;

  WaterConfig({
    required this.dailyGoal,
    required this.isReminderActive,
  });

  factory WaterConfig.fromFirestore(Map<String, dynamic>? data) {
    return WaterConfig(
      dailyGoal: (data?['hydration_amount'] as num?)?.toDouble() ?? 3.5,
      isReminderActive: data?['hydration_reminder_active'] as bool? ?? false,
    );
  }
}

class WaterLogItem {
  final String id;
  final String title;
  final String time;
  final String amountString;
  final double amountLiters;
  final Color accentColor;

  WaterLogItem({
    required this.id,
    required this.title,
    required this.time,
    required this.amountString,
    required this.amountLiters,
    required this.accentColor,
  });
}