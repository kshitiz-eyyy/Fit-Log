import 'package:flutter/material.dart';

import '../model/water_log_model.dart';


class WaterRepository {
  // Mock initial history log items
  final List<WaterLogItem> _mockLogs = [
    WaterLogItem(
      id: '1',
      title: 'Bottled Water',
      time: '08:45 AM',
      amountString: '500ml',
      amountLiters: 0.5,
      accentColor: const Color(0xFFC6FF00),
    ),
    WaterLogItem(
      id: '2',
      title: 'Glass of Water',
      time: '10:15 AM',
      amountString: '250ml',
      amountLiters: 0.25,
      accentColor: const Color(0xFF00E5FF),
    ),
    WaterLogItem(
      id: '3',
      title: 'Protein Shake',
      time: '12:30 PM',
      amountString: '400ml',
      amountLiters: 0.4,
      accentColor: const Color(0xFFC6FF00),
    ),
  ];

  Future<List<WaterLogItem>> fetchHydrationLogs() async {
    // Simulating a minor network/database delay
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_mockLogs);
  }

  Future<void> saveLogItem(WaterLogItem item) async {
    _mockLogs.insert(0, item); // Add new logs to the top of the history list
  }
}