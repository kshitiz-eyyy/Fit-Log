import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  bool _sleepMode = true;


  bool _isAutoTrackingActive = true;
  bool _isCurrentlyAsleep = false;
  DateTime? _autoSleepStartTime;
  double _lastNightSleepHours = 7.2;
  double _currentAcceleration = 0.0;

  final List<double> _weeklySleepData = [0.75, 0.5, 0.65, 0.8, 0.55, 0.9, 0.4];
  final List<String> _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  

  static const double _movementThreshold = 0.5;
  static const Duration _stillnessNeededForSleep = Duration(minutes: 10);
  
  DateTime _lastSignificantMovement = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (_isAutoTrackingActive) {
      _startSensorTracking();
    }
  }

  void _startSensorTracking() {
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (!_isAutoTrackingActive) return;

      final double acceleration = (event.x.abs() + event.y.abs() + (event.z.abs() - 9.81).abs());
      
      setState(() {
        _currentAcceleration = acceleration;
      });

      if (acceleration > _movementThreshold) {
        _handleMovementDetected();
      } else {
        _checkStillnessForSleep();
      }
    });
  }

  void _handleMovementDetected() {
    final now = DateTime.now();
    _lastSignificantMovement = now;

    if (_isCurrentlyAsleep) {
      setState(() {
        _isCurrentlyAsleep = false;
        if (_autoSleepStartTime != null) {
          final duration = now.difference(_autoSleepStartTime!);
          // Convert to hours
          _lastNightSleepHours = duration.inMinutes / 60.0;
          
          int todayIndex = (now.weekday - 1) % 7;
          _weeklySleepData[todayIndex] = (_lastNightSleepHours / 8.0).clamp(0.0, 1.0);
        }
      });
    }
  }

  void _checkStillnessForSleep() {
    if (_isCurrentlyAsleep) return;

    final now = DateTime.now();
    final timeSinceMovement = now.difference(_lastSignificantMovement);

    // Mock criteria: If phone is still for 10 mins and it's typical sleep time (e.g., 9 PM - 9 AM)
    bool isSleepTime = now.hour >= 21 || now.hour <= 9;

    if (timeSinceMovement > _stillnessNeededForSleep && isSleepTime) {
      setState(() {
        _isCurrentlyAsleep = true;
        // The user likely fell asleep at the start of the stillness period
        _autoSleepStartTime = _lastSignificantMovement;
      });
    }
  }

  void _stopSensorTracking() {
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    setState(() {
      _isCurrentlyAsleep = false;
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        title: const Text('FitLog Sleep', style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSleepProgress(),
            const SizedBox(height: 24),
            _buildAutomationStatusBadge(),
            const SizedBox(height: 12),
            _buildDebugSensorInfo(),
            const SizedBox(height: 32),
            _buildSleepHistoryChart(),
            const SizedBox(height: 24),
            _buildTrackingSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugSensorInfo() {
    bool isMoving = _currentAcceleration > _movementThreshold;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SENSOR ACTIVITY", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(
                isMoving ? "MOVING" : "STILL",
                style: TextStyle(
                  color: isMoving ? Colors.orange : Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (_currentAcceleration / 2.0).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(isMoving ? Colors.orange : Colors.green),
            minHeight: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSleepProgress() {
    double progressValue = _lastNightSleepHours / 8.0;
    const Color neonLime = Color(0xFFC6FF00);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: _isCurrentlyAsleep ? null : (progressValue > 1.0 ? 1.0 : progressValue),
            strokeWidth: 14,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(neonLime),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isCurrentlyAsleep ? "AUTO-DETECTED: ASLEEP" : "LAST NIGHT'S SLEEP",
              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              _isCurrentlyAsleep ? 'ZzZ' : '$_lastNightSleepHours',
              style: const TextStyle(
                color: neonLime,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _isCurrentlyAsleep ? 'SENSORS ACTIVE' : 'HOURS',
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAutomationStatusBadge() {
    const Color neonLime = Color(0xFFC6FF00);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: neonLime.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: neonLime.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 16, color: neonLime),
          const SizedBox(width: 8),
          Text(
            _isCurrentlyAsleep ? 'AUTOMATIC TRACKING IN PROGRESS' : 'SMART DETECTION READY',
            style: const TextStyle(color: neonLime, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepHistoryChart() {
    const Color neonLime = Color(0xFFC6FF00);
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_weeklySleepData.length, (index) {
          double heightMultiplier = _weeklySleepData[index] > 1.0 ? 1.0 : _weeklySleepData[index];
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 24,
                  height: 100 * heightMultiplier,
                  decoration: BoxDecoration(
                    color: neonLime.withOpacity(0.6),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(_days[index], style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTrackingSection() {
    const Color neonLime = Color(0xFFC6FF00);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTrackingRow(
            icon: Icons.hdr_auto,
            title: 'Auto Sleep Detection',
            subtitle: 'Uses machine learning & hardware sensors',
            value: _isAutoTrackingActive,
            onChanged: (val) {
              setState(() {
                _isAutoTrackingActive = val;
                if (val) {
                  _startSensorTracking();
                } else {
                  _stopSensorTracking();
                }
              });
            },
            activeColor: neonLime,
          ),
          const Divider(color: Colors.white10, height: 32),
          _buildTrackingRow(
            icon: Icons.nightlight_round,
            title: 'Sleep Mode',
            subtitle: 'Automatic silencing',
            value: _sleepMode,
            onChanged: (val) => setState(() => _sleepMode = val),
            activeColor: neonLime,
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
    required Color activeColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: activeColor.withOpacity(0.5),
          activeColor: activeColor,
        ),
      ],
    );
  }
}