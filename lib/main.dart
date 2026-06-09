import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/admin_panel_screen.dart';
import 'package:fitlog/view/contact_dietitan_screen.dart';
import 'package:fitlog/view/contact_trainer_screen.dart';
import 'package:fitlog/view/fitlog_login.dart';
import 'package:fitlog/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Add this import




import 'firebase_options.dart';
import 'view/library.dart';
import 'view/activity_screen.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/dashboard.dart';
import 'view/features_screen.dart';
import 'view/splash_screen.dart';

void main() async {
  // Side note: Since you imported firebase_options, make sure you initialize Firebase
  // if you haven't already done so elsewhere!
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // 2. Wrap your app with the provider here
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: const FitLogApp(),
    ),
  );
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
      home: DashboardScreen(),
    );
  }
}