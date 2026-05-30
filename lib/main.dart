import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/meal_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/library.dart';
import 'view/activity_screen.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/dashboard.dart';
import 'view/features_screen.dart';
import 'view/splash_screen.dart';
import 'view/membership_tracking_screen.dart';

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