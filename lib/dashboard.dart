import 'package:flutter/material.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'package:audioplayers/audioplayers.dart'; // ✅ Correct import

// Dashboard Screen with navigation
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _DashboardContent(),
    Center(child: Text("FEATURES", style: TextStyle(color: Colors.white))),
    LibraryScreen(),
    ActivityScreen(),
    Center(child: Text("PROFILE", style: TextStyle(color: Colors.white))),
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

// Dashboard Content
class _DashboardContent extends StatefulWidget {
  const _DashboardContent();

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // ✅ Audio player instance

  @override
  Widget build(BuildContext context) {
    // Membership dates: start today, end after 30 days
    final DateTime membershipStart = DateTime.now();
    final DateTime membershipEnd = membershipStart.add(const Duration(days: 30));
    final int remainingDays = membershipEnd.difference(DateTime.now()).inDays;
    final int totalDays = membershipEnd.difference(membershipStart).inDays;
    final double progress = (totalDays - remainingDays) / totalDays;

    bool fatigueWarning = true; // simulate fatigue condition
    double energyLevel = 0.5;   // simulate energy slider

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FitnessCoachChatScreen()),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ... your existing widgets (banner, progress ring, stats, streak, membership, calendar, hydration, mood, fatigue)

            const SizedBox(height: 20),

            // Audio-Guided Daily Flash
            ElevatedButton.icon(
              onPressed: () async {
                // Example: play audio from network
                await _audioPlayer.play(
                  UrlSource("https://www.example.com/daily_flash.mp3"),
                );

                // Example: play audio from local asset
                // await _audioPlayer.play(AssetSource("audio/daily_flash.mp3"));
              },
              icon: const Icon(Icons.play_circle_fill),
              label: const Text("Daily Flash"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
            ),

            const SizedBox(height: 20),

            // Start Workout Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                side: const BorderSide(color: Color(0xFFCCFF00), width: 2),
                elevation: 20,
                shadowColor: const Color(0xFFCCFF00),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Starting workout...")),
                );
              },
              icon: const Icon(Icons.play_arrow, size: 28),
              label: const Text("START WORKOUT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),

            const SizedBox(height: 30),

            // Motivational Quote Section
            Container(
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
                children: const [
                  Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 28),
                  SizedBox(height: 8),
                  Text(
                    "“Discipline is the bridge between goals and accomplishment.”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Reusable stat card
  static Widget _statCard(String value, String label, IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFCCFF00).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFCCFF00), size: 32),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  // Progress Bar Widget
  static Widget _progressBar(String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[800],
          color: color,
          minHeight: 10,
        ),
      ],
    );
  }
}

// Placeholder for AI Fitness Coach Chat Screen
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
        child: Text(
          "Chat with your AI Fitness Coach here...",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
