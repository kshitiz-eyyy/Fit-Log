import 'package:flutter/material.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'package:audioplayers/audioplayers.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _DashboardContent(),
    const Center(
      child: Text(
        "FEATURES",
        style: TextStyle(color: Colors.white),
      ),
    ),
    LibraryScreen(),
    ActivityScreen(),
    const Center(
      child: Text(
        "PROFILE",
        style: TextStyle(color: Colors.white),
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_video_outlined),
            label: "Features",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

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
    final DateTime membershipEnd =
    membershipStart.add(const Duration(days: 30));

    final int remainingDays =
        membershipEnd.difference(DateTime.now()).inDays;

    final int totalDays =
        membershipEnd.difference(membershipStart).inDays;

    final double progress =
        (totalDays - remainingDays) / totalDays;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FitnessCoachChatScreen(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF121212),
                    Color(0xFF1E1E1E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "WELCOME BACK, COMMANDER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "A step ahead than yesterday",
                    style: TextStyle(
                      color: Color(0xFFCCFF00),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Circular Progress Ring
            SizedBox(
              height: 180,
              width: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade800,
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFFCCFF00),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "75% DAILY GOAL",
                        style: TextStyle(
                          color: Color(0xFFCCFF00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "1,240 STEPS\n45 MINS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Quick Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statCard(
                  "142 BPM",
                  "Peak Level",
                  Icons.favorite,
                ),
                _statCard(
                  "842 KCAL",
                  "Burned",
                  Icons.local_fire_department,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Progress Bars
            _progressBar(
              "Steps Goal",
              0.75,
              Colors.greenAccent,
            ),

            const SizedBox(height: 12),

            _progressBar(
              "Workout Time",
              0.45,
              Colors.blueAccent,
            ),

            const SizedBox(height: 12),

            _progressBar(
              "Calories Burned",
              0.65,
              Colors.orangeAccent,
            ),

            const SizedBox(height: 20),

            // Streak Tracker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFCCFF00),
                  width: 2,
                ),
              ),
              child: const Text(
                "12 DAY STREAK\nPERSONAL RECORD",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCCFF00),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Membership Tracker
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFCCFF00),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Membership Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Days Remaining: $remainingDays",
                    style: const TextStyle(
                      color: Color(0xFFCCFF00),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.greenAccent,
                    minHeight: 10,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Calendar Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: totalDays,
              itemBuilder: (context, index) {
                final dayNumber = index + 1;

                final isLastWeek =
                    dayNumber > (totalDays - 7);

                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isLastWeek
                        ? Colors.redAccent
                        : const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFCCFF00),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "$dayNumber",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Water & Meal Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Water logged!"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.water_drop),
                  label: const Text("Log Water"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Meal logged!"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.restaurant),
                  label: const Text("Log Meal"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Energy Slider
            Slider(
              value: energyLevel,
              min: 0,
              max: 1,
              divisions: 2,
              label: energyLevel < 0.5
                  ? "Low Energy"
                  : "High Energy",
              onChanged: (val) {
                setState(() {
                  energyLevel = val;
                });
              },
            ),

            Text(
              energyLevel < 0.5
                  ? "Recommended: Gentle Yoga / Stretching"
                  : "Recommended: Intense Cardio / HIIT",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            // Fatigue Warning
            if (fatigueWarning)
              Container(
                padding: const EdgeInsets.all(16),
                margin:
                const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "⚠️ Muscle fatigue is high. Stretch or recover today!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Daily Flash Audio
            ElevatedButton.icon(
              onPressed: () async {
                await _audioPlayer.play(
                  UrlSource(
                    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_fill),
              label: const Text("Daily Flash"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
              ),
            ),

            const SizedBox(height: 20),

            // Start Workout Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                side: const BorderSide(
                  color: Color(0xFFCCFF00),
                  width: 2,
                ),
                elevation: 20,
                shadowColor: const Color(0xFFCCFF00),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Starting workout..."),
                  ),
                );
              },
              icon: const Icon(
                Icons.play_arrow,
                size: 28,
              ),
              label: const Text(
                "START WORKOUT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Motivational Quote
            Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFCCFF00)
                        .withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.format_quote,
                    color: Color(0xFFCCFF00),
                    size: 28,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "“Discipline is the bridge between goals and accomplishment.”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
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

  // Stat Card
  static Widget _statCard(
      String value,
      String label,
      IconData icon,
      ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
            const Color(0xFFCCFF00).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFFCCFF00),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Progress Bar
  static Widget _progressBar(
      String label,
      double progress,
      Color color,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
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
}

// AI Fitness Coach Screen
class FitnessCoachChatScreen extends StatelessWidget {
  const FitnessCoachChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "AI Fitness Coach",
          style: TextStyle(
            color: Color(0xFFCCFF00),
          ),
        ),
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