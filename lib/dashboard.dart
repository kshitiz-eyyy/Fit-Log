import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'features_screen.dart';
import 'chatbot.dart';
import 'meal_tracking_screen.dart';
import 'bmi_calculator_screen.dart';
import 'workout_timer_screen.dart';
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


            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 16),
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
                            Text("Calories", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


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


            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: _actionButton("Log Meal", Icons.restaurant, Colors.orangeAccent, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MealTrackingScreen(),
                  ),
                );
              }),
            ),


            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.2), width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCFF00).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.workspace_premium, color: Color(0xFFCCFF00), size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "ACCOUNT PLAN",
                              style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "FitLog Pro Access",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.stars_rounded,
                        color: Color(0xFFCCFF00),
                        size: 28,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Color(0xFF262626), height: 1),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.4), width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.settings_suggest_outlined, color: Color(0xFFCCFF00), size: 16),
                          SizedBox(width: 8),
                          Text(
                            "MANAGE SUBSCRIPTION",
                            style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCCFF00), size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),


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