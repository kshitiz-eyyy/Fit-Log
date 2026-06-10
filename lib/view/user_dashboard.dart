import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features_screen.dart';
import 'user_library.dart';
import 'user_activity_screen.dart';
import 'user_profile.dart';
import 'bmi_calculator_screen.dart';
import 'workout_timer_screen.dart';
import 'meal_tracking_screen.dart';
import 'chatbot.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _userName = "FitLog Athlete";
  bool _isPremiumOverridden = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfileName();
  }

  Future<void> _loadUserProfileName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "FitLog Athlete";
      _isPremiumOverridden = prefs.getBool('admin_force_premium') ?? false;
    });
  }

  List<Widget> get _screens => [
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

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      _loadUserProfileName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: [
                        Text(
                          _userName,
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _isPremiumOverridden ? "Pro Premium Member (Global Override)" : "Regular Access Member",
                          style: TextStyle(
                              color: _isPremiumOverridden ? const Color(0xFFCCFF00) : Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                          ),
                        ),
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
            const Spacer(),
            const Divider(color: Color(0xFF262626)),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Sign Out Session", style: TextStyle(color: Colors.redAccent)),
              onTap: () async {
                Navigator.pop(context);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('is_logged_in', false);

                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (Route<dynamic> route) => false,
                  );
                }
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

  double _volumeProgress = 14200.0;
  final double _volumeTarget = 20000.0;
  bool _isJoinedCommunityChallenge = false;

  String _globalChallengeHeadline = "Solstice 100k Squat Blast";
  String _systemNoticeAlertText = "";
  bool _showSystemNoticeBanner = false;
  bool _isPremiumUser = false;

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
      internalCaloriesEaten = prefs.getInt('total_calories_eaten') ?? 1850;
      double weight = prefs.getDouble('user_weight') ?? 70.0;
      double height = prefs.getDouble('user_height') ?? 175.0;
      currentStreak = prefs.getInt('user_current_streak') ?? 5;
      personalRecordStreak = prefs.getInt('user_max_streak') ?? 12;
      loggedToday = prefs.getBool('user_logged_today') ?? false;
      _isJoinedCommunityChallenge = prefs.getBool('challenge_joined_community') ?? false;

      _globalChallengeHeadline = prefs.getString('admin_global_challenge_name') ?? "Solstice 100k Squat Blast";
      _systemNoticeAlertText = prefs.getString('admin_system_notice_text') ?? "Scheduled backend database sync at midnight.";
      _showSystemNoticeBanner = prefs.getBool('flag_show_notice') ?? false;
      _isPremiumUser = prefs.getBool('admin_force_premium') ?? false;

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

  Future<void> _toggleCommunityChallenge() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isJoinedCommunityChallenge = !_isJoinedCommunityChallenge;
    });
    await prefs.setBool('challenge_joined_community', _isJoinedCommunityChallenge);
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
              _notificationItem(Icons.workspace_premium, "Subscription Status Check", _isPremiumUser ? "Global premium plan activation verified." : "Standard subscription tier verified."),
              _notificationItem(Icons.local_fire_department, "Calorie Target Goal Alert", "You are within 15% of hitting your target metrics today."),
              _notificationItem(Icons.water_drop, "Hydration Reminder", "Time to log another 250ml water window input."),
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
    double caloriePercentage = (internalCaloriesEaten / currentTargetCalories).clamp(0.0, 1.0);
    int caloriesRemaining = max(0, currentTargetCalories - internalCaloriesEaten);
    double waterRemaining = max(0.0, 3.5 - hydrationAmount);

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
          if (_isPremiumUser)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(Icons.workspace_premium, color: Color(0xFFCCFF00), size: 20),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
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
      body: RefreshIndicator(
        color: const Color(0xFFCCFF00),
        backgroundColor: const Color(0xFF161616),
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showSystemNoticeBanner && _systemNoticeAlertText.isNotEmpty)
                Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _systemNoticeAlertText.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFFCCFF00).withOpacity(0.08),
                          border: Border.all(color: const Color(0xFFCCFF00), width: 0.8),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 24),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_currentQuote, style: const TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.local_fire_department, color: loggedToday ? const Color(0xFFCCFF00) : Colors.grey, size: 28),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("$currentStreak DAY STREAK", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                  Text("Personal Record: $personalRecordStreak days", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: _toggleDailyLog,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: loggedToday ? Colors.grey : const Color(0xFFCCFF00)),
                              backgroundColor: loggedToday ? Colors.transparent : const Color(0xFFCCFF00).withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(
                              loggedToday ? "COMPLETED" : "LOG TODAY",
                              style: TextStyle(color: loggedToday ? Colors.grey : const Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator(
                                    value: caloriePercentage,
                                    strokeWidth: 6,
                                    backgroundColor: Colors.grey.shade900,
                                    valueColor: const AlwaysStoppedAnimation(Color(0xFFCCFF00)),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("$internalCaloriesEaten", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
                                    const Text("kcal eaten", style: TextStyle(color: Colors.grey, fontSize: 9)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("TARGET VELOCITY ENGINE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.flag_outlined, color: Color(0xFFCCFF00), size: 14),
                                    const SizedBox(width: 6),
                                    Text("$caloriesRemaining kcal deficit left", style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.water_drop_outlined, color: Colors.blueAccent, size: 14),
                                    const SizedBox(width: 6),
                                    Text("${waterRemaining.toStringAsFixed(2)} L fluid remaining", style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: const Color(0xFF262626), borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    caloriePercentage >= 1.0 ? "METABOLIC SURPLUS MET" : "CALORIC DEFICIT PROFILE ACTIVE",
                                    style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 9, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
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
                            child: _buildMetricCard("BODY MASS INDEX", "$displayBmiValue", bmiStatusText, Icons.scale),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMetricCard("DAILY METABOLIC", "$internalCaloriesEaten / $currentTargetCalories", "Target Floor Window", Icons.local_fire_department),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.water_drop, color: Color(0xFFCCFF00), size: 14),
                                    SizedBox(width: 6),
                                    Text("HYDRATION", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text("$hydrationAmount L", style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                                const Text("Daily Target: 3.5 Liters", style: TextStyle(color: Colors.grey, fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.notifications_active_outlined, color: Color(0xFFCCFF00), size: 14),
                                    SizedBox(width: 6),
                                    Text("HYDRO RADAR", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Switch(
                                  value: hydrationReminderActive,
                                  activeColor: const Color(0xFFCCFF00),
                                  onChanged: (val) => setState(() => hydrationReminderActive = val),
                                ),
                                Text(hydrationReminderActive ? "Hourly Alerts Active" : "Alert Pings Paused", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "ACTIVE GOALS & CHALLENGES",
                      style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.fitness_center, color: Color(0xFFCCFF00), size: 14),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text("Iron Warrior Volume Target", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                "${((_volumeProgress / _volumeTarget) * 100).toInt()}%",
                                style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("${_volumeProgress.toInt()}kg / ${_volumeTarget.toInt()}kg Lifted", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: _volumeProgress / _volumeTarget,
                              backgroundColor: const Color(0xFF262626),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCCFF00)),
                              minHeight: 4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161616),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCCFF00).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.emoji_events_outlined, color: Color(0xFFCCFF00), size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("COMMUNITY EVENT", style: TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                                Text(
                                  _globalChallengeHeadline,
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _isJoinedCommunityChallenge ? "Status: Engaged & Tracking" : "Status: Open Registration",
                                  style: TextStyle(color: _isJoinedCommunityChallenge ? const Color(0xFFCCFF00) : Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: _toggleCommunityChallenge,
                            style: TextButton.styleFrom(
                              backgroundColor: _isJoinedCommunityChallenge ? Colors.transparent : const Color(0xFFCCFF00),
                              side: _isJoinedCommunityChallenge ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              _isJoinedCommunityChallenge ? "LEAVE" : "JOIN",
                              style: TextStyle(color: _isJoinedCommunityChallenge ? Colors.grey : Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealTrackingScreen()));
                        _loadDashboardData();
                      },
                      icon: const Icon(Icons.restaurant, color: Colors.black, size: 18),
                      label: const Text("OPEN MEAL DIARY LOG", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCCFF00), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutTimerScreen()));
                        _loadDashboardData();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, foregroundColor: const Color(0xFFCCFF00), padding: const EdgeInsets.symmetric(vertical: 14), shape: const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFCCFF00), width: 1))),
                      child: const Text("START ACTIVE TRAINING TIMER", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon) {
    return Container(
      height: 120,
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
          Text(subtitle, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}