<<<<<<< HEAD
import 'package:fitlog/account_screen.dart';
import 'package:fitlog/change_password_screen.dart';
import 'package:fitlog/fuel_log_screen.dart';
import 'package:fitlog/hydration_settings_screen.dart';
import 'package:flutter/material.dart';
import 'personal_details_screen.dart';
import 'hydration_settings_screen.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/library.dart';
import 'view/activity_screen.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/dashboard.dart';
import 'view/features_screen.dart';
import 'view/splash_screen.dart';
import 'view/membership_tracking_screen.dart';

>>>>>>> fa5419a6feadf0df5a9bb965f23933aa3b521a44
void main() {
  runApp(const FitLogApp());
}

class FitLogApp extends StatelessWidget {
  const FitLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const FuelLogScreen(),
    );
  }
}
=======
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

      home: const MembershipTrackingScreen(),
    );
  }
}
>>>>>>> fa5419a6feadf0df5a9bb965f23933aa3b521a44
