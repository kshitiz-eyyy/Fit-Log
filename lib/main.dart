import 'package:firebase_core/firebase_core.dart';
import 'package:fitlog/view/period_cycle.dart';
import 'package:fitlog/view/user_dashboard.dart';
import 'package:fitlog/viewmodel/theme_view_model.dart';
import 'package:fitlog/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';

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
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const FitLogApp(),
    ),
  );
}

class FitLogApp extends StatelessWidget {
  const FitLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FitLog',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeViewModel.themeMode,
          home: DashboardScreen(),
        );
      },
    );
  }
}
