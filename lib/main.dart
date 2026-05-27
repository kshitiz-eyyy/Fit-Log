import 'package:fitlog/account_screen.dart';
import 'package:fitlog/change_password_screen.dart';
import 'package:fitlog/fuel_log_screen.dart';
import 'package:fitlog/hydration_settings_screen.dart';
import 'package:flutter/material.dart';
import 'personal_details_screen.dart';
import 'hydration_settings_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const FuelLogScreen(),
    );
  }
}
