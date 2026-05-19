import 'package:flutter/material.dart';
import 'workout_tracking_screen.dart';
import 'meal_tracking_screen.dart';
import 'membership_tracking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WorkoutTrackingScreen(),
    );
  }
}