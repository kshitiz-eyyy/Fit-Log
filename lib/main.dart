import 'package:fitlog/exercise_details_screen.dart';
import 'package:flutter/material.dart';
import 'chest_exercise.dart';
import 'history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      home: ExerciseDetailsScreen(),
    );
  }
}
