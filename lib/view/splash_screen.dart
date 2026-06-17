import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitlog/view/welcome_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  static const Color bgColor = Color(0xFF121212);
  static const Color neonLime = Color(0xFFCCFF00);
  static const Color textGray = Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(
                    "assets/images/logo.png",
                    height: 100,
                    fit: BoxFit.contain,
                  ),

                  // Brand Text
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: neonLime,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Industrial Athleticism Tagline
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 12, height: 2, color: neonLime),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'INDUSTRIAL ATHLETICISM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      Container(width: 12, height: 2, color: neonLime),
                    ],
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        minHeight: 3,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(neonLime),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Layout: Aesthetic Grid Icons & Version Control Text
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center, color: neonLime, size: 16),
                      SizedBox(width: 16),
                      Icon(Icons.analytics_outlined, color: neonLime, size: 16),
                      SizedBox(width: 16),
                      Icon(Icons.grid_view_rounded, color: neonLime, size: 16),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'ELITE PERFORMANCE PROTOCOL V2.0',
                    style: TextStyle(
                      color: textGray,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}