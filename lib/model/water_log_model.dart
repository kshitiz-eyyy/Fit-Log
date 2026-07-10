import 'package:flutter/material.dart'; // 🟢 FIXED: This resolves the "Undefined class 'Color'" error shown in your screenshot!

class WaterConfig {
  final double dailyGoal;
  final double currentIntake;
  final bool isReminderActive;
  final String frequency;

  WaterConfig({
    required this.dailyGoal,
    required this.currentIntake,
    required this.isReminderActive,
    required this.frequency,
  });

  factory WaterConfig.fromFirestore(Map<String, dynamic>? data) {
    return WaterConfig(
      dailyGoal: (data?['hydration_goal'] as num?)?.toDouble() ?? 3.5,
      currentIntake: (data?['hydrationAmount'] as num?)?.toDouble() ?? 0.0,
      isReminderActive: data?['hydrationReminderActive'] as bool? ?? false,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'amountString': amountString,
      'amountLiters': amountLiters,
      'accentColor': accentColor.value,
    };
  }

  factory WaterLogItem.fromMap(Map<String, dynamic> map) {
    return WaterLogItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      time: map['time'] ?? '',
      amountString: map['amountString'] ?? '',
      amountLiters: (map['amountLiters'] as num?)?.toDouble() ?? 0.0,
      accentColor: Color(map['accentColor'] as int? ?? 0xFF00E5FF),
    );
  }
}