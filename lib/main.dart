import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/change_password_screen.dart';
import 'package:fitlog/view/hydration_settings_screen.dart';
import 'package:fitlog/view/dashboard.dart';
import 'package:fitlog/view/sleep_screen.dart';
import 'package:fitlog/view/water_tracker_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:fitlog/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase Engine Init Error: $e");
  }

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
      home: const SleepScreen(),

    );
  }
}
