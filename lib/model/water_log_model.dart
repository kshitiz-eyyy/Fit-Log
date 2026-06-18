import 'package:flutter/material.dart';

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