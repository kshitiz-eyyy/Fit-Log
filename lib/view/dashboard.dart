import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_screen.dart';
import 'library.dart';
import 'features_screen.dart';
import 'chatbot.dart';
import 'meal_tracking_screen.dart';
import 'bmi_calculator_screen.dart';
import 'workout_timer_screen.dart';
import 'membership_tracking_screen.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    _DashboardContent(
      onNavigateToActivity: () => _onItemTapped(3),
      onNavigateToProfile: () => _onItemTapped(4),
    ),
    FeaturesScreen(),
    LibraryScreen(),
    const ActivityScreen(),
    const ProfileContent(), // Full Profile Screen Architecture Integrated
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      // Left Navigation Drawer Menu (Triggered by the top-left 3 lines)
      drawer: Drawer(
        backgroundColor: const Color(0xFF121212),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF161616)),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFCCFF00),
                    child: Icon(Icons.person, color: Colors.black, size: 35),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("FitLog Athlete", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Pro Premium Member", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text("Dashboard Home", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text("My Profile", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate, color: Colors.white),
              title: const Text("BMI Engine Analyzer", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer, color: Colors.white),
              title: const Text("Workout Session Timer", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutTimerScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_membership, color: Colors.white),
              title: const Text("Membership Operations", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipTrackingScreen()));
              },
            ),
            const Divider(color: Color(0xFF262626)),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Sign Out Session", style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
  final VoidCallback onNavigateToProfile;

  const _DashboardContent({
    required this.onNavigateToActivity,
    required this.onNavigateToProfile,
  });

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double hydrationAmount = 2.4;

  int internalCaloriesEaten = 0;
  int currentTargetCalories = 2500;
  double displayBmiValue = 24.2;
  String bmiStatusText = "Athletic Range";

  final List<String> _quotes = [
    "The only bad workout is the one that didn't happen.",
    "Success isn't always about greatness. It's about consistency.",
    "Your body can stand almost anything. It's your mind that you have to convince.",
  ];
  late String _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = _quotes[Random().nextInt(_quotes.length)];
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      internalCaloriesEaten = prefs.getInt('total_calories_eaten') ?? 3498;

      double weight = prefs.getDouble('user_weight') ?? 70.0;
      double height = prefs.getDouble('user_height') ?? 175.0;

      double heightInMeters = height / 100;
      if (heightInMeters > 0) {
        displayBmiValue = double.parse((weight / (heightInMeters * heightInMeters)).toStringAsFixed(1));
      }

      displayBmiValue = 22.9;
      bmiStatusText = "Normal Range";
      currentTargetCalories = 3330;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int remainingDays = 30;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: true,
        // Left Icon triggers Scaffold context's Drawer panel layout
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text(
          "FIT LOG",
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
            onPressed: widget.onNavigateToActivity, // Strictly bound to internal button tap
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: widget.onNavigateToProfile, // FIXED: Corrected mapping path to point to full Profile view
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FitnessCoachChatScreen()));
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
              decoration: BoxDecoration(color: const Color(0xFFCCFF00).withOpacity(0.1), border: Border.all(color: const Color(0xFFCCFF00), width: 1), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 28),
                  const SizedBox(width: 12),
                  Expanded(child: Text(_currentQuote, style: const TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic))),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
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
                            value: currentTargetCalories > 0 ? (internalCaloriesEaten / currentTargetCalories).clamp(0.0, 1.0) : 0,
                            strokeWidth: 6,
                            backgroundColor: Colors.grey.shade900,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFCCFF00)),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$internalCaloriesEaten", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30, height: 1)),
                            const Text("Calories", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10)),
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
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen()));
                      _loadDashboardData();
                    },
                    child: Container(
                      height: 140,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.scale, color: Color(0xFFCCFF00), size: 16),
                              SizedBox(width: 6),
                              Text("BODY MASS INDEX", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text("$displayBmiValue", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                          Text(bmiStatusText, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 12, fontWeight: FontWeight.bold)),
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
                        const Row(
                          children: [
                            Icon(Icons.local_fire_department, color: Color(0xFFCCFF00), size: 16),
                            SizedBox(width: 6),
                            Text("DAILY CALORIES", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "$internalCaloriesEaten", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                              TextSpan(text: " / $currentTargetCalories\nkcal", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: currentTargetCalories > 0 ? (internalCaloriesEaten / currentTargetCalories).clamp(0.0, 1.0) : 0,
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
                        const Row(
                          children: [
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
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade800, width: 0.5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
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
              child: _actionButton("Log Meal", Icons.restaurant, Colors.orangeAccent, () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealTrackingScreen()));
                _loadDashboardData();
              }, textColor: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.2), width: 1)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFCCFF00).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.workspace_premium, color: Color(0xFFCCFF00), size: 24),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ACCOUNT PLAN", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            SizedBox(height: 2),
                            Text("FitLog Pro Access", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Icon(Icons.stars_rounded, color: Color(0xFFCCFF00), size: 28),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: Color(0xFF262626), height: 1)),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipTrackingScreen()));
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.4), width: 1), borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings_suggest_outlined, color: Color(0xFFCCFF00), size: 16),
                          SizedBox(width: 8),
                          Text("MANAGE MEMBERSHIP", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.w900)),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutTimerScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, foregroundColor: const Color(0xFFCCFF00), padding: const EdgeInsets.symmetric(vertical: 16), shape: const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFCCFF00), width: 1.5))),
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
        style: ElevatedButton.styleFrom(backgroundColor: color, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      ),
    );
  }
}

// Complete, High-Quality Profile Interface View Model Configuration
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        title: const Text("MY PROFILE", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFCCFF00),
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text("FitLog Athlete", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("athlete@fitlog.com", style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 24),
            _profileStatTile(Icons.fitness_center, "Active Tier", "Premium Pro Access"),
            _profileStatTile(Icons.monitor_weight_outlined, "Target Framework", "Hypertrophy Recomp"),
            _profileStatTile(Icons.calendar_month, "Join Date", "June 2026"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipTrackingScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("EDIT MEMBERSHIP PROFILE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileStatTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFCCFF00)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}