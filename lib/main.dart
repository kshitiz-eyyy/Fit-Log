import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'history.dart';

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
      home: HistoryScreen(),
    );
  }
}
