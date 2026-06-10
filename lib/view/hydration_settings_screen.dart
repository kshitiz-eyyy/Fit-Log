import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class HydrationPreferencesScreen extends StatefulWidget {
  const HydrationPreferencesScreen({super.key});

  @override
  State<HydrationPreferencesScreen> createState() => _HydrationPreferencesScreenState();
}

class _HydrationPreferencesScreenState extends State<HydrationPreferencesScreen> {
  // --- STATE VARIABLES ---
  double _dailyTargetLiters = 3.5;
  double _currentIntakeLiters = 1.25; // Pre-filled sample starting data
  bool _intakeReminders = true;
  int _selectedIntervalHours = 2; // 1, 2, or 3 Hours
  bool _smartReminder = true;

  // Dynamic Next Drink Tracking
  late DateTime _nextDrinkTime;
  String _timeRemainingStr = "";
  Timer? _countdownTimer;

  // --- DESIGN SYSTEM COLORS ---
  static const backgroundColor = Color(0xFF0C0C0C);
  static const accentColor = Color(0xFFD4FF00); // Lime Green
  static const cardColor = Color(0xFF141414);
  static const surfaceColor = Color(0xFF1A1A1A);
  static const textColor = Colors.white;
  static const secondaryTextColor = Color(0xFF8E8E8E);
  static const warningColor = Color(0xFFFF5A1F);

  @override
  void initState() {
    super.initState();
    _calculateNextDrinkTime();
    _startCountdownTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  // --- HELPER LOGIC ---
  void _calculateNextDrinkTime() {
    // Calculates a mockup next target time from "now" based on selected user frequency
    _nextDrinkTime = DateTime.now().add(Duration(hours: _selectedIntervalHours));
    _updateCountdownString();
  }

  void _updateCountdownString() {
    final now = DateTime.now();
    final difference = _nextDrinkTime.difference(now);

    if (difference.isNegative) {
      setState(() {
        _timeRemainingStr = "Due Now";
      });
    } else {
      final hours = difference.inHours;
      final minutes = difference.inMinutes.remainder(60);
      setState(() {
        _timeRemainingStr = hours > 0 ? "${hours}h ${minutes}m" : "${minutes}m left";
      });
    }
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) _updateCountdownString();
    });
  }

  void _logWater(double amountLiters) {
    setState(() {
      _currentIntakeLiters = (_currentIntakeLiters + amountLiters).clamp(0.0, _dailyTargetLiters + 2.0);
      // Reset the window timer whenever user logs water intake
      _calculateNextDrinkTime();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          amountLiters >= 0 
            ? 'Logged +${(amountLiters * 1000).toInt()}ml of water!'
            : 'Removed ${(amountLiters.abs() * 1000).toInt()}ml of water!'
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: cardColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Ring progress multiplier configuration
  double get _progressRatio {
    if (_dailyTargetLiters <= 0) return 0.0;
    return (_currentIntakeLiters / _dailyTargetLiters).clamp(0.0, 1.0);
  }

  // --- BOTTOM DIALOG INTERFACE ---
  void _showSetTargetBottomSheet() {
    double tempTarget = _dailyTargetLiters;
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ADJUST DAILY TARGET',
                    style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Set your target daily fluid consumption limits.',
                    style: TextStyle(color: secondaryTextColor, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: accentColor, size: 32),
                        onPressed: () => setModalState(() => tempTarget = (tempTarget - 0.25).clamp(1.0, 8.0)),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        '${tempTarget.toStringAsFixed(2)} L',
                        style: const TextStyle(color: textColor, fontSize: 36, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: accentColor, size: 32),
                        onPressed: () => setModalState(() => tempTarget = (tempTarget + 0.25).clamp(1.0, 8.0)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() => _dailyTargetLiters = tempTarget);
                        Navigator.pop(context);
                      },
                      child: const Text('CONFIRM TARGET', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: accentColor, size: 24),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'FITLOG',
          style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF222222)),
                  color: cardColor,
                ),
                child: const Icon(Icons.person_outline, color: secondaryTextColor, size: 22),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // --- CIRCULAR ANIMATED/INTERACTIVE INDICATOR ---
                    GestureDetector(
                      onTap: _showSetTargetBottomSheet,
                      behavior: HitTestBehavior.opaque,
                      child: Tooltip(
                        message: "Tap to adjust goal",
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 220,
                                height: 220,
                                child: CustomPaint(
                                  painter: HydrationProgressPainter(progress: _progressRatio),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _currentIntakeLiters.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: accentColor,
                                          fontSize: 54,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10, left: 1),
                                        child: Text(
                                          '/ ${_dailyTargetLiters.toStringAsFixed(1)}L',
                                          style: const TextStyle(
                                            color: secondaryTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'COMPLETED',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900, // Fixed: Changed from FontWeight.black
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '👉 TAP TO CHANGE TARGET',
                                    style: TextStyle(color: secondaryTextColor, fontSize: 8, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- PREDICTIVE DYNAMIC NEXT TIMER ROW ---
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111600),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2B3300)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hourglass_top_rounded, color: accentColor, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            _intakeReminders ? 'NEXT REMINDER: $_timeRemainingStr' : 'REMINDERS ARE OFF',
                            style: const TextStyle(color: accentColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- NEW FUNCTIONALITY: QUICK WATER INTAKE LOGGING SECTION ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOG RECENT INTAKE',
                          style: TextStyle(color: secondaryTextColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _logWater(0.25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF222222))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.local_cafe_outlined, color: textColor, size: 20),
                                      SizedBox(height: 2),
                                      Text('+250 ml (Cup)', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: InkWell(
                                onTap: () => _logWater(-0.25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF222222))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.remove_circle_outline, color: warningColor, size: 20),
                                      SizedBox(height: 2),
                                      Text('-250 ml (Undo)', style: TextStyle(color: warningColor, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // --- CARD 1: INTAKE REMINDERS TOGGLE ---
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(14)),
                            child: const Icon(Icons.notifications_none_outlined, color: accentColor, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Intake Reminders', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text('Push notifications to drink water', style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                              ],
                            ),
                          ),
                          Switch(
                            value: _intakeReminders,
                            onChanged: (val) {
                              setState(() {
                                _intakeReminders = val;
                              });
                            },
                            activeThumbColor: Colors.black,
                            activeTrackColor: accentColor,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: const Color(0xFF2C2C2E),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- CARD 2: INTERVAL FREQUENCY SELECTOR ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'INTERVAL FREQUENCY',
                            style: TextStyle(color: secondaryTextColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: _buildIntervalButton('Every 1H', 1)),
                              const SizedBox(width: 10),
                              Expanded(child: _buildIntervalButton('Every 2H', 2)),
                              const SizedBox(width: 10),
                              Expanded(child: _buildIntervalButton('Every 3H', 3)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- CARD 3: SMART REMINDER CARD ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.flash_on, color: warningColor, size: 18),
                              const SizedBox(width: 6),
                              const Text('Smart Reminder', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFF2C140E), borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  'HIGH INTENSITY',
                                  style: TextStyle(color: warningColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5), // Fixed: Changed from FontWeight.black
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Dynamic frequency based on sweat rate & activity heart rate.',
                            style: TextStyle(color: secondaryTextColor, fontSize: 13, height: 1.4),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Switch(
                                value: _smartReminder,
                                onChanged: (val) => setState(() => _smartReminder = val),
                                activeThumbColor: Colors.white,
                                activeTrackColor: warningColor,
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: const Color(0xFF2C2C2E),
                              ),
                              const SizedBox(width: 8),
                              const Text('Enabled for Elite Pro', style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // --- FIXED SAVE BUTTON BLOCK ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preferences saved successfully!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SAVE PREFERENCES',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalButton(String label, int valueHours) {
    final isSelected = _selectedIntervalHours == valueHours;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIntervalHours = valueHours;
          _calculateNextDrinkTime();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? accentColor : surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// --- DYNAMIC ARC PROGRESS PAINTER ---
class HydrationProgressPainter extends CustomPainter {
  final double progress;
  HydrationProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;
    const strokeWidth = 10.0;

    // Track Background ring
    final trackPaint = Paint()
      ..color = const Color(0xFF1C1C1E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Active Highlight Progress Segment
    final progressPaint = Paint()
      ..color = const Color(0xFFD4FF00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw active arc from top center (-pi / 2)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant HydrationProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}