import 'package:flutter/material.dart';
import 'library.dart';
import 'history.dart';
import 'favourite_exercise.dart';

void main() {
  runApp(FitLogApp());
}

class FitLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitLog',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.lightGreenAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: FavouriteExerciseScreen(),
    );
  }
}
