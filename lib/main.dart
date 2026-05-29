import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD

// Teammate's imports
import 'package:fitlog/bmi_calculator_screen.dart';
import 'package:fitlog/fitlog_login.dart';
import 'package:fitlog/forgot_password_screen.dart';
import 'package:fitlog/register_screen.dart';
import 'package:fitlog/workout_timer_screen.dart';

import 'library.dart';
import 'activity_screen.dart';
import 'favourite_exercise.dart';
import 'change_password_screen.dart';
import 'dashboard.dart';
import 'features_screen.dart';
import 'splash_screen.dart';
=======
>>>>>>> 27c451ffebb4a1b0af647655be65a845dab755a9

import 'firebase_options.dart';
import 'view/library.dart';
import 'view/activity_screen.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/dashboard.dart';
import 'view/features_screen.dart';
import 'view/splash_screen.dart';

void main() {
  runApp(const FitLogApp());
}

class FitLogApp extends StatelessWidget {
  const FitLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitLog',

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.lightGreenAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      home: const DashboardScreen(),
    );
  }
}