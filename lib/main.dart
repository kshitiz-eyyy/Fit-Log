import 'package:fitlog/exercise_details_screen.dart';
import 'package:flutter/material.dart';
import 'exerciselistscreen.dart';
import 'exercise_data.dart';
import 'exercise_details_screen.dart';
import 'library.dart';


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

      home: LibraryScreen(),
    );
  }
}
