import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/favourite_exercise.dart';
import 'package:fitlog/view/fitlog_login.dart';
import 'package:fitlog/view/library.dart';
import 'package:fitlog/view/user_dashboard.dart';
import 'package:fitlog/view/user_profile.dart';
import 'package:fitlog/viewmodel/exercise_view_model.dart';
import 'package:fitlog/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ExerciseViewModel()),
      ],
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
        home: DashboardScreen()
    );
  }
}