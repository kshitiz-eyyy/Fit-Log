import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'chest_exercise.dart';
=======
import 'calorie_tracker_screen.dart';
>>>>>>> faeb548 (calorie_tracker screen added)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      home: ChestExerciseScreen(), // this will show your chest exercise screen
=======
      title: 'FitLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalorieTrackerScreen(),
>>>>>>> faeb548 (calorie_tracker screen added)
    );
  }
}
