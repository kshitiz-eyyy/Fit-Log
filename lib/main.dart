import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/admin_dashboard.dart';
import 'package:fitlog/view/meal_tracking_screen.dart';
import 'package:fitlog/view/testing_gateway_screen.dart;.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/user_library.dart';
import 'view/user_activity_screen.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/user_dashboard.dart';
import 'view/features_screen.dart';
import 'view/splash_screen.dart';
import 'view/premium_membership.dart';
import 'view/workout_tracking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase Engine Init Error: $e");
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

      home: const TestingGatewayScreen(),
    );
  }
}