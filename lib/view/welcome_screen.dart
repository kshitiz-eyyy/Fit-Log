import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  // Logo area with subtle glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Radial glow effect
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFC6FF00).withOpacity(0.12),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Logo Image from assets
                      Image.asset(
                        'assets/images/logo.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Welcome Text
                  const Text(
                    'WELCOME TO\nFITLOG',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                      letterSpacing: -1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  Text(
                    'Your journey to elite performance\nstarts here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Spacer(flex: 5),
                ],
              ),
            ),
          ),

          // Version Footer
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Text(
              'v2.0.0 • SYSTEM ACTIVE',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.2),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
