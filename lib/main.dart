import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/admin_panel_screen.dart';

import 'package:fitlog/view/contact_dietitan_screen.dart';
import 'package:fitlog/view/contact_trainer_screen.dart';
import 'package:fitlog/view/fitlog_login.dart';
import 'package:fitlog/view/rate_screen.dart';
import 'package:fitlog/view/terms_and_conditions_screen.dart';
import 'package:fitlog/view/track_membershiscreen.dart';
import 'package:fitlog/view/user_dashboard.dart';
import 'package:fitlog/view/welcome_screen.dart';
import 'package:fitlog/viewmodel/user_view_model.dart';

import 'package:fitlog/view/meal_tracking_screen.dart';
import 'package:fitlog/view/user_profile.dart';
import 'package:provider/provider.dart';
import 'view/fitlog_login.dart';
import 'package:fitlog/view/testing_gateway_screen.dart;.dart';

import 'package:flutter/material.dart';





import 'firebase_options.dart';
import 'view/library.dart';
import 'view/favourite_exercise.dart';
import 'view/change_password_screen.dart';
import 'view/features_screen.dart' hide TrackMembershipScreen;
import 'view/splash_screen.dart';


import 'view/fitlog_premium_screen.dart';
import 'view/workout_tracking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
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
        home:const TrackMembershipScreen()
    );
  }
}