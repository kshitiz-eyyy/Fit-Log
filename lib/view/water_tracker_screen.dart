import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Handles dynamic sessions securely!
import 'dart:math' as math;

import '../model/water_log_model.dart';
import '../repo/water_repository.dart';
import '../viewmodel/water_tracker_view_model.dart';


class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  late WaterRepository _repository;
  late WaterTrackerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _repository = WaterRepository();

    // 1. Detect who is signed into this device right now
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String targetUid = currentUser?.uid ?? '';

    // 2. Bind the ViewModel instantly to that session token
    _viewModel = WaterTrackerViewModel(
      repository: _repository,
      userId: targetUid,
    );
  }

  static const darkBackground = Color(0xFF121212);
  static const surfaceDark = Color(0xFF1E1E1E);
  static const primaryOrange = Color(0xFFFF6D00);
  static const secondaryLime = Color(0xFFC6FF00);
  static const cyanBlue = Color(0xFF00E5FF);
  static const textGray = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        if (_viewModel.isLoadingConfig) {
          return const Scaffold(
            backgroundColor: darkBackground,
            body: Center(child: CircularProgressIndicator(color: cyanBlue)),
          );
        }

        return Scaffold(
          backgroundColor: darkBackground,
          appBar: AppBar(
            backgroundColor: darkBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
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
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.water_drop, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Water Tracker',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  _buildProgressCircle(),

                  const SizedBox(height: 20),
                  Text(
                    'GOAL: ${_viewModel.goal} LITERS',
                    style: const TextStyle(
                      color: textGray,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      _buildQuickAddButton('+ 1 Cup', Icons.local_cafe_outlined, 0.25, 'Cup of Water'),
                      const SizedBox(width: 12),
                      _buildQuickAddButton('+ 500ml', Icons.water_drop_outlined, 0.5, 'Bottled Water'),
                      const SizedBox(width: 12),
                      _buildQuickAddButton('- 250ml', Icons.remove_circle_outline, -0.25, 'Adjustment Correction'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildReminderSettings(),
                  const SizedBox(height: 32),
                  _buildHydrationLog(),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _viewModel.addWater(0.25, title: 'Generic Track'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryOrange,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      child: const Text(
                        '+ Add Water',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
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
              progress: _viewModel.goal > 0 ? _viewModel.currentIntake / _viewModel.goal : 0.0,
              accentColor1: secondaryLime,
              accentColor2: cyanBlue,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _viewModel.currentIntake.toStringAsFixed(1),
                style: const TextStyle(
                  color: secondaryLime,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'LITERS',
                style: TextStyle(color: textGray, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddButton(String label, IconData icon, double amount, String itemTitle) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _viewModel.addWater(amount, title: itemTitle),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: surfaceDark, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: cyanBlue, size: 32),
              const SizedBox(height: 12),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
              const Row(
                children: [
                  Icon(Icons.alarm, color: secondaryLime, size: 24),
                  SizedBox(width: 12),
                  Text('REMINDER SETTINGS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Switch(
                value: _viewModel.remindersEnabled,
                onChanged: (val) => _viewModel.toggleReminders(val),
                activeThumbColor: Colors.white,
                activeTrackColor: secondaryLime,
                inactiveTrackColor: Colors.grey[800],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Frequency', style: TextStyle(color: textGray, fontSize: 16)),
              PopupMenuButton<String>(
                onSelected: (String value) => _viewModel.updateFrequency(value),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(value: 'Every 30 min', child: Text('Every 30 min')),
                  const PopupMenuItem<String>(value: 'Every 1 hour', child: Text('Every 1 hour')),
                  const PopupMenuItem<String>(value: 'Every 2 hours', child: Text('Every 2 hours')),
                ],
                child: Row(
                  children: [
                    Text(_viewModel.frequency, style: const TextStyle(color: secondaryLime, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: textGray, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHydrationLog() {
    if (_viewModel.logs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('HYDRATION LOG', style: TextStyle(color: textGray, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _viewModel.logs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => _buildLogItem(_viewModel.logs[index]),
        ),
      ],
    );
  }

  Widget _buildLogItem(WaterLogItem item) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: surfaceDark, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: item.accentColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
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
                      color: item.accentColor.withOpacity(0.1),
                      border: Border.all(color: item.accentColor),
                    ),
                    child: Icon(Icons.check, color: item.accentColor, size: 18),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(item.time, style: const TextStyle(color: textGray, fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  Text(item.amountString, style: TextStyle(color: item.accentColor, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterProgressPainter extends CustomPainter {
  final double progress;
  final Color accentColor1;
  final Color accentColor2;

  WaterProgressPainter({required this.progress, required this.accentColor1, required this.accentColor2});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10;
    const strokeWidth = 14.0;

    final trackPaint = Paint()
      ..color = Colors.grey[800]!.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

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

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress.clamp(0.0, 1.0), false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => oldDelegate.progress != progress;
}