import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  // --- COLORS ---
  static const darkBackground = Color(0xFF121212);
  static const surfaceDark = Color(0xFF1E1E1E);
  static const primaryOrange = Color(0xFFFF6D00);
  static const secondaryLime = Color(0xFFC6FF00);
  static const cyanBlue = Color(0xFF00E5FF);
  static const textGray = Color(0xFFBDBDBD);

  // --- STATE ---
  double _currentIntake = 2.4;
  final double _goal = 3.5;
  bool _remindersEnabled = true;
  String _frequency = "Every 1 hour";

  void _addWater(double amount) {
    setState(() {
      _currentIntake = (_currentIntake + amount).clamp(0.0, 9.9);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'FIT LOG',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.water_drop, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Water Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Circular Progress
              _buildProgressCircle(),

              const SizedBox(height: 20),
              Text(
                'GOAL: $_goal LITERS',
                style: const TextStyle(
                  color: textGray,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 40),

              // Quick Add Buttons
              Row(
                children: [
                  _buildQuickAddButton('+ 1 Cup', Icons.local_cafe_outlined, 0.25),
                  const SizedBox(width: 12),
                  _buildQuickAddButton('+ 500ml', Icons.water_drop_outlined, 0.5),
                  const SizedBox(width: 12),
                  _buildQuickAddButton('- 250ml', Icons.remove_circle_outline, -0.25),
                ],
              ),

              const SizedBox(height: 32),

              // Reminder Settings
              _buildReminderSettings(),

              const SizedBox(height: 32),

              // Hydration Log
              _buildHydrationLog(),

              const SizedBox(height: 32),

              // Add Water Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _addWater(0.25),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '+ Add Water',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProgressCircle() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(220, 220),
            painter: WaterProgressPainter(
              progress: _currentIntake / _goal,
              accentColor1: secondaryLime,
              accentColor2: cyanBlue,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currentIntake.toStringAsFixed(1),
                style: const TextStyle(
                  color: secondaryLime,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'LITERS',
                style: TextStyle(
                  color: textGray,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddButton(String label, IconData icon, double amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _addWater(amount),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: surfaceDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: cyanBlue, size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderSettings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cyanBlue.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.alarm, color: secondaryLime, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'REMINDER SETTINGS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _remindersEnabled,
                onChanged: (val) => setState(() => _remindersEnabled = val),
                activeColor: Colors.white,
                activeTrackColor: secondaryLime,
                inactiveTrackColor: Colors.grey[800],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Frequency',
                style: TextStyle(color: textGray, fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    _frequency,
                    style: const TextStyle(
                      color: secondaryLime,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, color: textGray, size: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHydrationLog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HYDRATION LOG',
          style: TextStyle(
            color: textGray,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 20),
        _buildLogItem('Bottled Water', '08:45 AM', '500ml', secondaryLime),
        const SizedBox(height: 16),
        _buildLogItem('Glass of Water', '10:15 AM', '250ml', cyanBlue),
        const SizedBox(height: 16),
        _buildLogItem('Protein Shake', '12:30 PM', '400ml', secondaryLime),
      ],
    );
  }

  Widget _buildLogItem(String title, String time, String amount, Color accent) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent.withOpacity(0.1),
                      border: Border.all(color: accent),
                    ),
                    child: Icon(Icons.check, color: accent, size: 18),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(color: textGray, fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    amount,
                    style: TextStyle(
                      color: accent,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: darkBackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: secondaryLime,
      unselectedItemColor: const Color(0xFF48484A),
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Features'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Library'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}

class WaterProgressPainter extends CustomPainter {
  final double progress;
  final Color accentColor1;
  final Color accentColor2;

  WaterProgressPainter({
    required this.progress,
    required this.accentColor1,
    required this.accentColor2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;
    const strokeWidth = 14.0;

    // Background circle
    final trackPaint = Paint()
      ..color = Colors.grey[800]!.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepGradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: [accentColor1, accentColor2, accentColor1],
      stops: const [0.0, 0.5, 1.0],
    );

    final progressPaint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
