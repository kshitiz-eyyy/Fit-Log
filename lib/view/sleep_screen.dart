import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  bool _sleepMode = true;
  bool _bedtimeAlarm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'FIT LOG',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSleepProgress(),
            const SizedBox(height: 24),
            _buildQualityBadge(),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SLEEP HISTORY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSleepHistoryChart(),
            const SizedBox(height: 24),
            _buildTrackingSection(),
            const SizedBox(height: 24),
            _buildLogSleepButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepProgress() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: 0.75,
            strokeWidth: 14,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "LAST NIGHT'S SLEEP",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '7.5',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'HOURS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQualityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF152A2D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1E3A3E)),
      ),
      child: const Text(
        'QUALITY: GOOD SLEEP',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSleepHistoryChart() {
    final data = [0.4, 0.5, 0.45, 0.35, 0.65, 0.15, 0.85, 0.3];
    final days = ['M', 'T', 'W', 'T', 'V', 'F', 'S', 'S'];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 32,
                height: 140 * data[index],
                decoration: BoxDecoration(
                  color: data[index] > 0.2 ? const Color(0xFF2E6B75) : const Color(0xFF1A3B40),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                days[index],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTrackingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E6B75).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TONIGHT'S TRACKING",
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildTrackingRow(
            icon: Icons.nightlight_round,
            title: 'Sleep Mode',
            subtitle: 'Automatic silencing',
            value: _sleepMode,
            onChanged: (val) => setState(() => _sleepMode = val),
          ),
          const Divider(color: Colors.white10, height: 32),
          _buildTrackingRow(
            icon: Icons.alarm,
            title: 'Bedtime Alarm',
            subtitle: 'Wake up at 06:30 AM',
            value: _bedtimeAlarm,
            onChanged: (val) => setState(() => _bedtimeAlarm = val),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: Colors.cyanAccent,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[800],
        ),
      ],
    );
  }

  Widget _buildLogSleepButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[900],
          shape: RoundedCornerShape(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.edit_calendar, color: Colors.black, size: 24),
            SizedBox(width: 12),
            Text(
              'LOG SLEEP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom shape for the button
class RoundedCornerShape extends OutlinedBorder {
  final double radius;
  const RoundedCornerShape(this.radius);

  @override
  OutlinedBorder copyWith({BorderSide? side}) => RoundedCornerShape(radius);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedCornerShape(radius * t);
}
