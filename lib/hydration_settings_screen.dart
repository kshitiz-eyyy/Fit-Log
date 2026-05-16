import 'package:flutter/material.dart';
import 'dart:math' as math;

class HydrationSettingsScreen extends StatefulWidget {
  const HydrationSettingsScreen({super.key});

  @override
  State<HydrationSettingsScreen> createState() => _HydrationSettingsScreenState();
}

class _HydrationSettingsScreenState extends State<HydrationSettingsScreen> {
  bool _intakeRemindersEnabled = true;
  bool _smartReminderEnabled = true;
  String _selectedFrequency = 'Every 1H';

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0D0D0D);
    const cardColor = Color(0xFF1C1C1E);
    const accentColor = Color(0xFFD0FD3E);
    const orangeColor = Color(0xFFFF5722);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E93);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: accentColor, size: 24),
                  ),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cardColor,
                    ),
                    child: const Icon(Icons.person_outline, color: Colors.grey, size: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Daily Target Circle
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(200, 200),
                            painter: CircleProgressPainter(
                              progress: 0.83,
                              color: accentColor,
                              backgroundColor: const Color(0xFF2C2C2E),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '3.5',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12, left: 4),
                                    child: Text(
                                      'L',
                                      style: TextStyle(
                                        color: accentColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'DAILY TARGET',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Motivation Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.local_fire_department, color: orangeColor, size: 16),
                        SizedBox(width: 12),
                        Text(
                          'Stay hydrated, perform better.',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Intake Reminders Card
                    _buildSettingsCard(
                      cardColor: cardColor,
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF252527),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.notifications_none, color: accentColor, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Intake Reminders',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Push notifications to drink water',
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _intakeRemindersEnabled,
                            onChanged: (val) => setState(() => _intakeRemindersEnabled = val),
                            activeColor: Colors.white,
                            activeTrackColor: accentColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Interval Frequency
                    _buildSettingsCard(
                      cardColor: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'INTERVAL FREQUENCY',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _buildFrequencyButton('Every 1H', accentColor)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildFrequencyButton('Every 2H', accentColor)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildFrequencyButton('Every 3H', accentColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Smart Reminder
                    _buildSettingsCard(
                      cardColor: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bolt, color: orangeColor, size: 16),
                              const SizedBox(width: 12),
                              const Text(
                                'Smart Reminder',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3A2016),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'HIGH INTENSITY',
                                  style: TextStyle(
                                    color: orangeColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Dynamic frequency based on sweat rate & activity heart rate.',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Switch(
                                value: _smartReminderEnabled,
                                onChanged: (val) => setState(() => _smartReminderEnabled = val),
                                activeColor: Colors.white,
                                activeTrackColor: orangeColor,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Enabled for Elite Pro',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Monitoring Window
                    _buildSettingsCard(
                      cardColor: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'MONITORING WINDOW',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _buildTimeInput('START TIME', '07:00')),
                              const SizedBox(width: 12),
                              Expanded(child: _buildTimeInput('END TIME', '22:00')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'SAVE PREFERENCES',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 3,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dash'),
          const BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Train'),
          const BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Fuel'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.analytics, color: Colors.black, size: 22),
            ),
            label: 'Goals',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Admin'),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required Color cardColor, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildFrequencyButton(String text, Color accentColor) {
    bool isSelected = _selectedFrequency == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = text),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? accentColor : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeInput(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    const strokeWidth = 10.0;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
