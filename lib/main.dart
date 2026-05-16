import 'package:fitlog/bmi_calculator_screen.dart';
import 'package:fitlog/fitlog_login.dart';
import 'package:fitlog/forgot_password_screen.dart';
import 'package:fitlog/register_screen.dart';
import 'package:fitlog/workout_timer_screen.dart';
import 'package:flutter/material.dart';
import 'change_password_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkoutTimerScreen(),
    );
  }
}

