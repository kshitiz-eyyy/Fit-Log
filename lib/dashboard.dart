import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'bmi_calculator_screen.dart';
import 'features_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _DashboardContent(),
    FeaturesScreen(),
    LibraryScreen(),
    ActivityScreen(),
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
        backgroundColor: const Color(0xFF121212),
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

// --- FITLOG DASHBOARD CONTENT ---
class _DashboardContent extends StatefulWidget {
  const _DashboardContent();

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double energyLevel = 0.5;
  bool fatigueWarning = true;

  @override
  Widget build(BuildContext context) {
    final DateTime membershipStart = DateTime.now();
    final DateTime membershipEnd = membershipStart.add(const Duration(days: 30));
    final int remainingDays = membershipEnd.difference(DateTime.now()).inDays;
    final int totalDays = membershipEnd.difference(membershipStart).inDays;
    final double progress = (totalDays - remainingDays) / totalDays;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FitnessCoachChatScreen()));
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // HEADER
            Column(
              children: const [
                Text("FITLOG",
                    style: TextStyle(color: Color(0xFFCCFF00), fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2)),
                SizedBox(height: 6),
                Text("WELCOME BACK, COMMANDER",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text("Your recovery is peaking. CNS fatigue is low.",
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
              ],
            ),
            const SizedBox(height: 30),

            // READINESS RING
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 0.88,
                    strokeWidth: 14,
                    backgroundColor: Colors.grey.shade800,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFCCFF00)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("88 READINESS",
                          style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 6),
                      Text("Optimal Performance State", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // QUICK METRICS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _metricCard("CNS", "FRESH", Icons.bolt),
                _metricCard("HRV", "84ms", Icons.favorite),
                _metricCard("Sleep", "92%", Icons.bedtime),
              ],
            ),
            const SizedBox(height: 20),

            // PROGRESS BARS
            _progressBar("Steps Goal", 0.75, Colors.greenAccent),
            const SizedBox(height: 12),
            _progressBar("Workout Time", 0.45, Colors.blueAccent),
            const SizedBox(height: 12),
            _progressBar("Calories Burned", 0.65, Colors.orangeAccent),
            const SizedBox(height: 20),

            // STREAK TRACKER
            _highlightCard("12 DAY STREAK\nPERSONAL RECORD"),
            const SizedBox(height: 20),

            // MEMBERSHIP STATUS
            _membershipCard(remainingDays, progress),
            const SizedBox(height: 20),

            // HYDRATION + MEAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton("Log Water", Icons.water_drop, Colors.blueAccent, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Water logged!")));
                }),
                _actionButton("Log Meal", Icons.restaurant, Colors.orangeAccent, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Meal logged!")));
                }),
              ],
            ),
            const SizedBox(height: 20),

            // ENERGY SLIDER
            Slider(
              value: energyLevel,
              divisions: 2,
              label: energyLevel < 0.5 ? "Low Energy" : "High Energy",
              onChanged: (val) => setState(() => energyLevel = val),
            ),
            Text(
              energyLevel < 0.5 ? "Recommended: Gentle Yoga / Stretching" : "Recommended: Intense Cardio / HIIT",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // FATIGUE WARNING
            if (fatigueWarning) _warningCard("⚠️ Muscle fatigue is high. Stretch or recover today!"),
            const SizedBox(height: 20),

            // DAILY FLASH AUDIO
            _actionButton("Daily Flash", Icons.play_circle_fill, Colors.purpleAccent, () async {
              await _audioPlayer.play(UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));
            }),
            const SizedBox(height: 20),

            // START WORKOUT
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Starting workout...")));
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text("START WORKOUT"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                side: const BorderSide(color: Color(0xFFCCFF00), width: 2),
                elevation: 20,
                shadowColor: const Color(0xFFCCFF00),
              ),
            ),
            const SizedBox(height: 30),

            // MOTIVATIONAL QUOTE
            _quoteCard("“Discipline is the bridge between goals and accomplishment.”"),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE WIDGETS ---
  static Widget _metricCard(String title, String value, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCFF00), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFCCFF00)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _progressBar(String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          color: color,
          minHeight: 10,
        ),
      ],
    );
  }

  static Widget _highlightCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCFF00), width: 2),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFFCCFF00),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  static Widget _membershipCard(int remainingDays, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCFF00), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Membership Status",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text("Days Remaining: $remainingDays",
              style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey,
            color: Colors.greenAccent,
            minHeight: 10,
          ),
        ],
      ),
    );
  }

  static Widget _actionButton(String text, IconData icon, Color color, Function onTap) {
    return ElevatedButton.icon(
      onPressed: () => onTap(),
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static Widget _warningCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }

  static Widget _quoteCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCCFF00).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 28),
          const SizedBox(height: 8),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

// --- FITNESS COACH CHAT SCREEN ---
class FitnessCoachChatScreen extends StatelessWidget {
  const FitnessCoachChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("AI Fitness Coach", style: TextStyle(color: Color(0xFFCCFF00))),
      ),
      body: const Center(
        child: Text("Chat with your AI Fitness Coach here...", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

