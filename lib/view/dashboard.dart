import 'package:fitlog/view/fitlog_premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlog/view/features_screen.dart';
import 'package:fitlog/view/library.dart';
import 'package:fitlog/view/user_activity_screen.dart';
import 'package:fitlog/view/user_profile.dart';
import 'package:fitlog/view/bmi_calculator_screen.dart';
import 'package:fitlog/view/workout_timer_screen.dart';
import 'package:fitlog/view/meal_tracking_screen.dart';
import 'package:fitlog/view/chatbot.dart';
import 'package:fitlog/view/water_tracker_screen.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _userName = "FitLog Athlete";

  @override
  void initState() {
    super.initState();
    _loadUserProfileName();
  }

  Future<void> _loadUserProfileName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "FitLog Athlete";
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      _loadUserProfileName();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _DashboardContent(
        onNavigateToActivity: () => _onItemTapped(3),
        onNavigateToProfile: () => _onItemTapped(4),
        onProfileUpdated: _loadUserProfileName,
      ),
      FeaturesScreen(),
      const LibraryScreen(),
      const ActivityScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      drawer: _buildDrawer(),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: const Color(0xFFCCFF00),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.featured_video_outlined), label: "Features"),
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
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
                    children: [
                      Text(
                        _userName,
                        style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const Text("Pro Premium Member", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11)),
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
            title: const Text("My Profile & Settings", style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.pop(context);
              _onItemTapped(4);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate, color: Colors.white),
            title: const Text("BMI Engine Analyzer", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen())).then((_) => _loadUserProfileName());
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FitLogPremiumScreen()));
            },
          ),
          const Spacer(),
          const Divider(color: Color(0xFF262626)),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Sign Out Session", style: TextStyle(color: Colors.redAccent)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  final VoidCallback onNavigateToActivity;
  final VoidCallback onNavigateToProfile;
  final VoidCallback onProfileUpdated;

  const _DashboardContent({
    required this.onNavigateToActivity,
    required this.onNavigateToProfile,
    required this.onProfileUpdated,
  });

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  double hydrationAmount = 2.4;
  int internalCaloriesEaten = 0;
  int currentTargetCalories = 2500;
  double displayBmiValue = 22.9;
  String bmiStatusText = "Normal Range";
  bool hydrationReminderActive = true;
  int currentStreak = 5;
  int personalRecordStreak = 12;
  bool loggedToday = false;

  final List<String> _quotes = [
    "Consistency beats talent every single day.",
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
      internalCaloriesEaten = prefs.getInt('total_calories_eaten') ?? 1850;
      double weight = prefs.getDouble('user_weight') ?? 70.0;
      double height = prefs.getDouble('user_height') ?? 175.0;
      currentStreak = prefs.getInt('user_current_streak') ?? 5;
      personalRecordStreak = prefs.getInt('user_max_streak') ?? 12;
      loggedToday = prefs.getBool('user_logged_today') ?? false;

      double heightInMeters = height / 100;
      if (heightInMeters > 0) {
        displayBmiValue = double.parse((weight / (heightInMeters * heightInMeters)).toStringAsFixed(1));
      }
      bmiStatusText = displayBmiValue < 25.0 ? "Normal Range" : "Overweight Range";
      currentTargetCalories = 2800;
    });
    widget.onProfileUpdated();
  }

  Future<void> _toggleDailyLog() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (loggedToday) {
        currentStreak = max(0, currentStreak - 1);
        loggedToday = false;
      } else {
        currentStreak += 1;
        if (currentStreak > personalRecordStreak) {
          personalRecordStreak = currentStreak;
        }
        loggedToday = true;
      }
    });
    await prefs.setInt('user_current_streak', currentStreak);
    await prefs.setInt('user_max_streak', personalRecordStreak);
    await prefs.setBool('user_logged_today', loggedToday);
  }

  void _openNotificationCenterOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161616),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("LIVE NOTIFICATION FEED", style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, fontSize: 13)),
                  IconButton(icon: const Icon(Icons.close, color: Colors.white, size: 18), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(color: Color(0xFF262626)),
              _notificationItem(Icons.workspace_premium, "Subscription Active", "Your FitLog Pro plan is active."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFCCFF00), size: 18),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _loadDashboardData();
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text("FIT LOG", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: _openNotificationCenterOverlay),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: widget.onNavigateToProfile,
              child: const CircleAvatar(radius: 15, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCCFF00),
        child: const Icon(Icons.chat, color: Colors.black),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FitnessCoachChatScreen())),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStreakCard(),
            const SizedBox(height: 12),
            _buildTargetCard(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen()));
                      _loadDashboardData();
                    },
                    child: _buildMetricCard("BODY MASS INDEX", "$displayBmiValue", bmiStatusText, Icons.scale),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard("DAILY METABOLIC", "$internalCaloriesEaten", "kcal eaten", Icons.local_fire_department),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const WaterTrackerScreen()));
                      _loadDashboardData();
                    },
                    child: _buildMetricCard("HYDRATION", "$hydrationAmount L", "Daily Target: 3.5L", Icons.water_drop),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard("TRAINING", "ACTIVE", "Next: Lower Body", Icons.fitness_center),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealTrackingScreen()));
                _loadDashboardData();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCCFF00), padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text("OPEN MEAL DIARY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: Color(0xFFCCFF00), size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$currentStreak DAY STREAK", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("PR: $personalRecordStreak days", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
          OutlinedButton(
            onPressed: _toggleDailyLog,
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFCCFF00))),
            child: Text(loggedToday ? "COMPLETED" : "LOG TODAY", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 10)),
          )
        ],
      ),
    );
  }

  Widget _buildTargetCard() {
    double progress = (internalCaloriesEaten / currentTargetCalories).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6,
              backgroundColor: Colors.grey.shade900,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFCCFF00)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("TARGET VELOCITY", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                Text("${currentTargetCalories - internalCaloriesEaten} kcal remaining", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade900, color: const Color(0xFFCCFF00)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFCCFF00), size: 14),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
          Text(subtitle, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 10)),
        ],
      ),
    );
  }
}
