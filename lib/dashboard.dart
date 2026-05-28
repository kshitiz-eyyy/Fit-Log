import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'activity_screen.dart';
import 'library.dart';
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
  const _DashboardContent();

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double energyLevel = 0.5;
  bool fatigueWarning = true;
  double hydrationAmount = 2.4;

  @override
  Widget build(BuildContext context) {
    final DateTime membershipStart = DateTime.now();
    final DateTime membershipEnd = membershipStart.add(const Duration(days: 30));
    final int remainingDays = membershipEnd.difference(DateTime.now()).inDays;
    final int totalDays = membershipEnd.difference(membershipStart).inDays;
    final double progress = (totalDays - remainingDays) / totalDays;

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
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 20, color: Colors.black),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FitnessCoachChatScreen()));
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

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
                            Text("88",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 36, height: 1)),
                            Text("READINESS",
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Optimal Performance State",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Water logged!")));
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
                          Text("CONSISTENCY", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          SizedBox(height: 4),
                          Text("Excellent", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 20, fontWeight: FontWeight.bold)),
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

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.calendar_today, color: Color(0xFFCCFF00), size: 18),
                      SizedBox(width: 8),
                      Text("Biological Cycle", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFF0F0F0F), borderRadius: BorderRadius.circular(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("CURRENT PHASE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("Follicular - Day 8", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Icon(Icons.opacity, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    decoration: const BoxDecoration(border: Border(left: BorderSide(color: Color(0xFFCCFF00), width: 2))),
                    child: const Text(
                      "Strength potential is rising. Optimal time for heavy compound lifts and high-intensity interval training.",
                      style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  _actionButton("Log Meal", Icons.restaurant, Colors.orangeAccent, () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Meal logged!")));
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

            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFCCFF00),
              child: Text(
                "12 DAY STREAK • PERSONAL RECORD REACHED (Progress: ${(progress * 100).toStringAsFixed(0)}%)",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1),
              ),
            ),
            const SizedBox(height: 16),

            if (fatigueWarning) ...[
              _warningCard("⚠️ Muscle fatigue is high. Stretch or recover today!"),
              const SizedBox(height: 16),
            ],


            _actionButton("Daily Flash Audio", Icons.play_circle_fill, const Color(0xFFCCFF00), () async {
              await _audioPlayer.play(UrlSource("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));
            }, textColor: Colors.black),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Starting workout...")));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFCCFF00), width: 1.5)),
              ),
              child: const Text("START WORKOUT", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
            const SizedBox(height: 32),


            const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 32),
            const Text(
              "\"Discipline is the bridge between goals and accomplishment.\"",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, height: 1.3),
            ),
            const SizedBox(height: 6),
            const Text(
              "— KINETIC ELITE PROTOCOL",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
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

  static Widget _warningCard(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.2),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Text(text, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }
}

// --- FITNESS COACH CHAT SCREEN ---
// --- FITNESS COACH CHAT SCREEN ---
class FitnessCoachChatScreen extends StatefulWidget {
  const FitnessCoachChatScreen({super.key});

  @override
  State<FitnessCoachChatScreen> createState() => _FitnessCoachChatScreenState();
}


class _FitnessCoachChatScreenState extends State<FitnessCoachChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hello! I am your AI Fitness Coach. Ask me anything about your training blocks, meal goals, hydration tracking, or grab some quick motivation!",
      "isUser": false,
      "time": "8:39 AM"
    }
  ];
  bool _isTyping = false;

  // Remembers the last thing suggested so follow-ups like "yes" make contextual sense
  String _activeIntent = "";

  void _sendMessage() {
    final String text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add({
        "text": text,
        "isUser": true,
        "time": _getCurrentTime(),
      });
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI thinking and reply stream
    Future.delayed(const Duration(seconds: 1, milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          "text": _getAIResponse(text),
          "isUser": false,
          "time": _getCurrentTime(),
        });
      });
      _scrollToBottom();
    });
  }

  String _getAIResponse(String query) {
    final lower = query.toLowerCase();

    // 1. Handle Contextual Affirmations ("yes", "sure", "ok", "yep")
    if (lower == "yes" || lower == "sure" || lower == "ok" || lower == "yep" || lower == "go check") {
      if (_activeIntent == "chest") {
        _activeIntent = ""; // Clear state after consuming
        return "Awesome! Head directly to the 'Library' section in your main navigation bar. Look for the 'Elite Chest Hypertrophy Block' to begin your session.";
      }
      if (_activeIntent == "diet") {
        _activeIntent = "";
        return "Perfect! Head back to the main Home Dashboard tab and scroll down to locate the orange 'Log Meal' button to register your macros.";
      }
      if (_activeIntent == "water") {
        _activeIntent = "";
        return "Understood. Tap back to your Home Dashboard and locate the 'HYDRATION' card. Use the neon green '+' button to track your clean fluids instantly.";
      }
    }

    // 2. Chest & Specific Exercise Intent
    if (lower.contains("chest") || lower.contains("bench") || lower.contains("push day") || lower.contains("pecs")) {
      _activeIntent = "chest";
      return "Since your central nervous system fatigue is tracking exceptionally low today, it's a great opportunity for high-intensity chest tracking. Would you like me to guide you to the Chest Exercise Library section?";
    }

    // 3. General Workout / Training Intent
    if (lower.contains("workout") || lower.contains("training") || lower.contains("lift") || lower.contains("exercise")) {
      _activeIntent = "";
      return "Your active schedule indicates 'Lower Body Hypertrophy' next. Your recovery state is peak (88 Readiness), optimized for heavy structural compounds. You have 29 days remaining on this block!";
    }

    // 4. Diet / Nutrition / Calories Intent
    if (lower.contains("diet") || lower.contains("meal") || lower.contains("eat") || lower.contains("calori") || lower.contains("food") || lower.contains("protein")) {
      _activeIntent = "diet";
      return "Current Metric Status: You've consumed 1,840 out of your 2,600 kcal ceiling. Would you like me to point you to the meal tracking section to manage your dynamic target macros?";
    }

    // 5. Hydration / Water Intent
    if (lower.contains("water") || lower.contains("hydrat") || lower.contains("drink")) {
      _activeIntent = "water";
      return "Your current system records sit at 2.4 Liters logged. Do you want me to show you how to update your daily water inputs on the dashboard?";
    }

    // 6. Motivation / Quotes Intent
    if (lower.contains("quote") || lower.contains("motivat") || lower.contains("lazy") || lower.contains("tired") || lower.contains("inspire")) {
      _activeIntent = "";
      return "⚡️ Protocol Check: 'Discipline is the bridge between goals and accomplishment.' You have secured a running 12-day streak. Protect your personal record—do not drop performance metrics today!";
    }

    // 7. Standard Fallback Route
    _activeIntent = "";
    return "Understood. Tell me more: are we reviewing your target chest movements, logging dietary macro targets, tracking fluid metrics, or pushing out system motivational quotes?";
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $amPm";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFCCFF00),
              child: Icon(Icons.smart_toy, size: 18, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("AI Coach", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Text("Online • Kinetic Protocol", style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat Container
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isUser = message["isUser"];

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFFCCFF00) : const Color(0xFF161616),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isUser ? 12 : 2),
                        bottomRight: Radius.circular(isUser ? 2 : 12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message["text"],
                          style: TextStyle(
                            color: isUser ? Colors.black : Colors.white,
                            fontSize: 14,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message["time"],
                            style: TextStyle(
                              color: isUser ? Colors.black54 : Colors.grey.shade600,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Typing State Monitor UI
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Coach is analyzing metrics...",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ),

          // Message Action Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF161616),
              border: Border(top: BorderSide(color: Colors.black45, width: 0.5)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: "Ask about your training, diet, motivation...",
                        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCCFF00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.black, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}