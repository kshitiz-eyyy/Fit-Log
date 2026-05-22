import 'package:flutter/material.dart';
import 'exerciselistscreen.dart';
import 'exercise_data.dart'; // <-- make sure this file exists

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
      // 👇 Pass a valid muscle group and its exercises
      home: ExerciseListScreen(
        muscleGroup: "Chest",          // Example: first screen shows Chest
        exercises: exerciseData["Chest"]!, // Comes from exercise_data.dart
      ),
    );
  }
}
