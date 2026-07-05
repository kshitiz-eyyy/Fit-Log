import 'package:fitlog/model/water_log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WaterConfig', () {
    test('creates default values when Firestore data is null', () {
      final config = WaterConfig.fromFirestore(null);

      expect(config.dailyGoal, 3.5);
      expect(config.isReminderActive, false);
      expect(config.frequency, 'Every 1 hour');
    });

    test('parses values correctly from Firestore data', () {
      final data = {
        'hydration_amount': 2.0,
        'hydration_reminder_active': true,
        'hydration_reminder_frequency': 'Every 30 minutes',
      };

      final config = WaterConfig.fromFirestore(data);

      expect(config.dailyGoal, 2.0);
      expect(config.isReminderActive, true);
      expect(config.frequency, 'Every 30 minutes');
    });
  });

  group('WaterLogItem', () {
    test('creates a valid log item', () {
      final item = WaterLogItem(
        id: '1',
        title: 'Morning Glass',
        time: '08:00 AM',
        amountString: '250ml',
        amountLiters: 0.25,
        accentColor: Colors.blue,
      );

      expect(item.id, '1');
      expect(item.title, 'Morning Glass');
      expect(item.time, '08:00 AM');
      expect(item.amountString, '250ml');
      expect(item.amountLiters, 0.25);
      expect(item.accentColor, Colors.blue);
    });
  });
}
