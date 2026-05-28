import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'features_screen.dart';
import 'chatbot.dart';
import 'meal_tracking_screen.dart';
import 'bmi_calculator_screen.dart';
import 'workout_timer_screen.dart'; // 👈 Added your new workout timer screen import
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    _DashboardContent(onNavigateToActivity: () => _onItemTapped(3)),
    FeaturesScreen(),
    LibraryScreen(),
    const ActivityScreen(),
    const Center(
      child: Text("PROFILE", style: TextStyle(color: Colors.white)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: const Color(0xFFCCFF00),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.featured_video_outlined), label: "Features"),
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  final VoidCallback onNavigateToActivity;

  const _DashboardContent({required this.onNavigateToActivity});

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double energyLevel = 0.5;
  bool fatigueWarning = true;
  double hydrationAmount = 2.4;

  final List<String> _quotes = [
    "The only bad workout is the one that didn't happen.",
    "Success isn't always about greatness. It's about consistency.",
    "Your body can stand almost anything. It's your mind that you have to convince.",
    "What hurts today makes you stronger tomorrow.",
    "Don't limit your challenges. Challenge your limits.",
    "Discipline is choosing between what you want now and what you want most.",
  ];

  late String _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = _quotes[Random().nextInt(_quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final DateTime membershipStart = DateTime.now();
    final DateTime membershipEnd = membershipStart.add(const Duration(days: 30));
    final int remainingDays = membershipEnd.difference(DateTime.now()).inDays;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          "Fit Log",
          style: TextStyle(
            color: Color(0xFFCCFF00),
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: widget.onNavigateToActivity,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: widget.onNavigateToActivity,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 20, color: Colors.black),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FitnessCoachChatScreen(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // MOTIVATIONAL QUOTE BANNER
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFCCFF00).withOpacity(0.1),
                border: Border.all(color: const Color(0xFFCCFF00), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _currentQuote,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // READINESS CARD
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: CircularProgressIndicator(
                            value: 0.88,
                            strokeWidth: 6,
                            backgroundColor: Colors.grey.shade900,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFCCFF00)),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("88", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 36, height: 1)),
                            Text("READINESS", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Optimal Performance State", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text(
                    "Your recovery is peaking. Central Nervous System fatigue is low, and your HRV indicates a high capacity for intense metabolic stress today.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _badge("CNS: FRESH"),
                      const SizedBox(width: 8),
                      _badge("HRV: 84MS"),
                      const SizedBox(width: 8),
                      _badge("SLEEP: 92%"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // GRID METRICS (BMI & Daily Calories)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BMICalculatorScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 140,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.scale, color: Color(0xFFCCFF00), size: 16),
                              SizedBox(width: 6),
                              Text("BODY MASS INDEX", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Text("24.2", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                          const Text("Athletic Range", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.local_fire_department, color: Color(0xFFCCFF00), size: 16),
                            SizedBox(width: 6),
                            Text("DAILY CALORIES", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(text: "1,840", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                              TextSpan(text: " / 2,600\nkcal", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: 1840 / 2600,
                          backgroundColor: Colors.grey.shade900,
                          color: const Color(0xFFCCFF00),
                          minHeight: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                // HYDRATION ACTION BLOCK
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.water_drop, color: Color(0xFFCCFF00), size: 16),
                            SizedBox(width: 6),
                            Text("HYDRATION", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$hydrationAmount", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                            GestureDetector(
                              onTap: () {
                                setState(() => hydrationAmount = double.parse((hydrationAmount + 0.2).toStringAsFixed(1)));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(color: const Color(0xFFCCFF00), borderRadius: BorderRadius.circular(2)),
                                child: const Icon(Icons.add, color: Colors.black, size: 18),
                              ),
                            )
                          ],
                        ),
                        const Text("Liters", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // TRAINING BLOCK
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade800, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.fitness_center, color: Color(0xFFCCFF00), size: 16),
                                SizedBox(width: 6),
                                Text("TRAINING", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              color: const Color(0xFFCCFF00),
                              child: const Text("ACTIVE", style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const Text("Next: Lower Body\nHypertrophy", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("$remainingDays Days Remaining", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // PROGRESS PROGRESSION BARS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  _progressBar("Steps Goal", 0.75, Colors.greenAccent),
                  const SizedBox(height: 12),
                  _progressBar("Workout Time", 0.45, Colors.blueAccent),
                  const SizedBox(height: 12),
                  _progressBar("Calories Burned", 0.65, Colors.orangeAccent),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SLEEP CARDS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.bedtime, color: Color(0xFFCCFF00), size: 18),
                      SizedBox(width: 8),
                      Text("Sleep Analysis", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("DEEP SLEEP", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          SizedBox(height: 4),
                          Text("2h 15m", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("CONSISTENCY", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _chartBar(20), _chartBar(35), _chartBar(75, isActive: true), _chartBar(30), _chartBar(40), _chartBar(85, isActive: true), _chartBar(25),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // DYNAMIC MEAL LOGGING INTERACTION ENGINE
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  _actionButton("Log Meal", Icons.restaurant, Colors.orangeAccent, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MealTrackingScreen(),
                      ),
                    );
                  }),
                  const SizedBox(height: 14),
                  Slider(
                    value: energyLevel,
                    divisions: 2,
                    activeColor: const Color(0xFFCCFF00),
                    inactiveColor: Colors.grey.shade900,
                    label: energyLevel < 0.5 ? "Low Energy" : "High Energy",
                    onChanged: (val) => setState(() => energyLevel = val),
                  ),
                  Text(
                    energyLevel < 0.5 ? "Recommended: Gentle Yoga / Stretching" : "Recommended: Intense Cardio / HIIT",
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // START WORKOUT BUTTON
            // 🚀 Updated: Triggers a navigation push to the workout timer screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkoutTimerScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFCCFF00), width: 1.5)),
              ),
              child: const Text("START WORKOUT", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _badge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCFF00), width: 1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  static Widget _chartBar(double height, {bool isActive = false}) {
    return Container(
      height: height,
      width: 20,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFCCFF00) : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  static Widget _progressBar(String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade900,
            color: color,
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  static Widget _actionButton(String text, IconData icon, Color color, Function onTap, {Color textColor = Colors.white}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => onTap(),
        icon: Icon(icon, color: textColor),
        label: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}