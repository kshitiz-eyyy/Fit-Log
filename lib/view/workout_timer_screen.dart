import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lines_painter.dart';

class WorkoutTimerScreen extends StatefulWidget {
  const WorkoutTimerScreen({super.key});

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  Timer? _internalTimer;
  int _secondsElapsed = 0;
  bool _isRunning = false;

  String _selectedExerciseProfile = "Lower Body Hypertrophy Block";
  final List<String> _exerciseOptions = [
    "Lower Body Hypertrophy Block",
    "Upper Body Push Intensity",
    "Posterior Chain Pull Focus",
    "Active Recovery Protocols",
    "High Intensity Core Circuit"
  ];

  static const Color bgColor = Color(0xFF121212);
  static const Color cardBgColor = Color(0xFF1E1E1E);
  static const Color neonLime = Color(0xFFCCFF00);
  static const Color textGray = Color(0xFF8E8E93);

  void _toggleTimer() {
    if (_isRunning) {
      _internalTimer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        _isRunning = true;
      });
      _internalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
  }

  Future<void> _stopTimer() async {
    _internalTimer?.cancel();
    setState(() {
      _isRunning = false;
    });

    if (_secondsElapsed > 0) {
      final int minutes = _secondsElapsed ~/ 60;
      final int seconds = _secondsElapsed % 60;
      final String durationText = minutes > 0
          ? "Duration: $minutes Mins $seconds Secs"
          : "Duration: $seconds Secs";

      final prefs = await SharedPreferences.getInstance();
      DateTime today = DateTime.now();
      String dateKey = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

      String existingWorkoutsJson = prefs.getString('workouts_$dateKey') ?? '{}';
      Map<String, dynamic> decodedWorkouts = jsonDecode(existingWorkoutsJson);

      String uniqueId = "train_${DateTime.now().millisecondsSinceEpoch}";
      decodedWorkouts[uniqueId] = {
        "title": _selectedExerciseProfile,
        "metric": durationText,
        "timestamp": DateTime.now().toIso8601String(),
      };

      await prefs.setString('workouts_$dateKey', jsonEncode(decodedWorkouts));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout profile logged successfully!'),
            backgroundColor: neonLime,
          ),
        );
      }
    }
  }

  void _resetTimer() {
    _internalTimer?.cancel();
    setState(() {
      _secondsElapsed = 0;
      _isRunning = false;
    });
  }

  String _formatDisplayTime() {
    final int minutes = _secondsElapsed ~/ 60;
    final int seconds = _secondsElapsed % 60;

    final String minutesString = minutes.toString().padLeft(2, '0');
    final String secondsString = seconds.toString().padLeft(2, '0');

    return "$minutesString:$secondsString";
  }

  @override
  void dispose() {
    _internalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 500) {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    const Text(
                      'WORKOUT',
                      style: TextStyle(
                        color: neonLime,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: cardBgColor,
                      child: Icon(Icons.person, color: textGray, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedExerciseProfile,
                      dropdownColor: cardBgColor,
                      icon: const Icon(Icons.keyboard_arrow_down, color: neonLime),
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedExerciseProfile = newValue;
                          });
                        }
                      },
                      items: _exerciseOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Text(
                      'CURRENT SET: 03 / 05',
                      style: TextStyle(
                        color: neonLime,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: DiagonalLinesPainter(lineColor: neonLime.withValues(alpha: 0.4)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          decoration: BoxDecoration(
                            color: cardBgColor.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'WORKOUT TIME',
                                style: TextStyle(
                                  color: textGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatDisplayTime(),
                                style: const TextStyle(
                                  color: neonLime,
                                  fontSize: 72,
                                  fontWeight: FontWeight.w900,
                                  fontFeatures: [FontFeature.tabularFigures()],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neonLime,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _toggleTimer,
                    child: Text(
                      _isRunning ? 'PAUSE' : 'START',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: _stopTimer,
                          icon: const Icon(Icons.stop_outlined, color: Colors.white),
                          label: const Text(
                            'STOP',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: _resetTimer,
                          icon: const Icon(Icons.refresh_outlined, color: Colors.white),
                          label: const Text(
                            'RESET',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}