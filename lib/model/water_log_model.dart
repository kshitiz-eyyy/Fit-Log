import 'package:flutter/material.dart'; // 🟢 FIXED: This resolves the "Undefined class 'Color'" error shown in your screenshot!

class WaterConfig {
  final double dailyGoal;
  final bool isReminderActive;
  final String frequency;

  WaterConfig({
    required this.dailyGoal,
    required this.isReminderActive,
    required this.frequency,
  });

  factory WaterConfig.fromFirestore(Map<String, dynamic>? data) {
    return WaterConfig(
      dailyGoal: (data?['hydration_amount'] as num?)?.toDouble() ?? 3.5,
      isReminderActive: data?['hydration_reminder_active'] as bool? ?? false,
      frequency: data?['hydration_reminder_frequency'] as String? ?? 'Every 1 hour',
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