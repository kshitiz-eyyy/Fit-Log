import 'package:fitlog/view/meal_tracking_screen.dart';
import 'package:fitlog/view/membership_tracking_screen.dart';
import 'package:fitlog/view/performance_screen.dart';
import 'package:fitlog/view/rate_screen.dart';
import 'package:fitlog/view/splash_screen.dart';
import 'package:fitlog/view/workout_tracking_screen.dart';
import 'package:flutter/material.dart';

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

      home: const SplashScreen(),
    );
  }
}