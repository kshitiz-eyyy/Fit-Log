import 'package:flutter/material.dart';
import 'library.dart';
import 'activity_screen.dart';
import 'favourite_exercise.dart';
import 'change_password_screen.dart';
import 'dashboard.dart';

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
      // 👇 Set your starting screen here
      home: const DashboardScreen(),
    );
  }
}
