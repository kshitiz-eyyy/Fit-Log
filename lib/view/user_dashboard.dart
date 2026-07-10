import 'package:flutter/material.dart';
import '../model/dashboard_model.dart';
import '../repo/dashboard_repo_impl.dart';
import '../viewmodel/dashboard_view_model.dart';
import 'features_screen.dart';
import 'user_library.dart';
import 'user_activity_screen.dart';
import 'user_profile.dart';
import 'bmi_calculator_screen.dart';
import 'workout_timer_screen.dart';
import 'meal_tracking_screen.dart';
import 'calorie_tracker_screen.dart';
import 'water_tracker_screen.dart';
import 'chatbot.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DashboardViewModel(repository: DashboardRepoImpl());
    _viewModel.addListener(_onViewModelStateUpdated);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelStateUpdated);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelStateUpdated() {
    if (mounted) setState(() {});
  }

  List<Widget> _getScreens(DashboardStateModel state) => [
    _DashboardContent(
      viewModel: _viewModel,
      onNavigateToActivity: () => _viewModel.updateNavigationIndex(3),
      onNavigateToProfile: () => _viewModel.updateNavigationIndex(4),
    ),
    FeaturesScreen(),
    const LibraryScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_viewModel.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00))),
      );
    }

    final state = _viewModel.state;

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
                          state.userName,
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.isPremiumUser ? "Pro Premium Member (Global Override)" : "Regular Access Member",
                          style: TextStyle(
                              color: state.isPremiumUser ? const Color(0xFFCCFF00) : Colors.grey,
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
                _viewModel.updateNavigationIndex(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text("My Profile & Settings", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _viewModel.updateNavigationIndex(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate, color: Colors.white),
              title: const Text("BMI Engine Analyzer", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen())).then((_) {
                  _viewModel.loadDashboardState();
                });
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
                await _viewModel.executeSignOutSession();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _getScreens(state)[_viewModel.currentNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: const Color(0xFFCCFF00),
        unselectedItemColor: Colors.grey,
        currentIndex: _viewModel.currentNavigationIndex,
        onTap: _viewModel.updateNavigationIndex,
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

class _DashboardContent extends StatelessWidget {
  final DashboardViewModel viewModel;
  final VoidCallback onNavigateToActivity;
  final VoidCallback onNavigateToProfile;

  const _DashboardContent({
    required this.viewModel,
    required this.onNavigateToActivity,
    required this.onNavigateToProfile,
  });

  void _openNotificationCenterOverlay(BuildContext context, DashboardStateModel state) {
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
              _notificationItem(Icons.workspace_premium, "Subscription Status Check", state.isPremiumUser ? "Global premium plan activation verified." : "Standard subscription tier verified."),
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
    final state = viewModel.state;
    double caloriePercentage = (state.internalCaloriesEaten / state.currentTargetCalories).clamp(0.0, 1.0);
    int caloriesRemaining = max(0, state.currentTargetCalories - state.internalCaloriesEaten);
    double waterRemaining = max(0.0, state.hydrationGoal - state.hydrationAmount);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            viewModel.loadDashboardState();
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text("FIT LOG", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () => _openNotificationCenterOverlay(context, state)),
          if (state.isPremiumUser)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(Icons.workspace_premium, color: Color(0xFFCCFF00), size: 20),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: GestureDetector(
              onTap: onNavigateToProfile,
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
        onRefresh: viewModel.loadDashboardState,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.showSystemNoticeBanner && state.systemNoticeAlertText.isNotEmpty)
                Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          state.systemNoticeAlertText.toUpperCase(),
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
                          color: const Color(0xFFCCFF00).withValues(alpha: 0.08),
                          border: Border.all(color: const Color(0xFFCCFF00), width: 0.8),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.format_quote, color: Color(0xFFCCFF00), size: 24),
                          const SizedBox(width: 12),
                          Expanded(child: Text(viewModel.currentQuote, style: const TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic))),
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
                              Icon(Icons.local_fire_department, color: state.loggedToday ? const Color(0xFFCCFF00) : Colors.grey, size: 28),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.currentStreak} DAY STREAK", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                  Text("Personal Record: ${state.personalRecordStreak} days", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: viewModel.toggleDailyStreakLog,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: state.loggedToday ? Colors.grey : const Color(0xFFCCFF00)),
                              backgroundColor: state.loggedToday ? Colors.transparent : const Color(0xFFCCFF00).withValues(alpha: 0.1),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(
                              state.loggedToday ? "COMPLETED" : "LOG TODAY",
                              style: TextStyle(color: state.loggedToday ? Colors.grey : const Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold),
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
                                    Text("${state.internalCaloriesEaten}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICalculatorScreen())).then((_) {
                                viewModel.loadDashboardState();
                              });
                            },
                            child: _buildMetricCard("BODY MASS INDEX", "${state.displayBmiValue}", state.bmiStatusText, Icons.scale),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CalorieTrackerScreen()),
                              ).then((_) {
                                viewModel.loadDashboardState();
                              });
                            },
                            child: _buildMetricCard("DAILY METABOLIC", "${state.internalCaloriesEaten} / ${state.currentTargetCalories}", "Target Floor Window", Icons.local_fire_department),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WaterTrackerScreen()),
                              ).then((_) {
                                viewModel.loadDashboardState();
                              });
                            },
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
                                  Text("${state.hydrationAmount} L", style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                                  Text("Daily Target: ${state.hydrationGoal} Liters", style: const TextStyle(color: Colors.grey, fontSize: 10)),
                                ],
                              ),
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
                                  value: state.hydrationReminderActive,
                                  activeColor: const Color(0xFFCCFF00),
                                  onChanged: viewModel.toggleHydrationRadarAlerts,
                                ),
                                Text(state.hydrationReminderActive ? "Hourly Alerts Active" : "Alert Pings Paused", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 10)),
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
                                "${((state.volumeProgress / state.volumeTarget) * 100).toInt()}%",
                                style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("${state.volumeProgress.toInt()}kg / ${state.volumeTarget.toInt()}kg Lifted", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: state.volumeProgress / state.volumeTarget,
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
                        border: Border.all(color: const Color(0xFFCCFF00).withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCCFF00).withValues(alpha: 0.1),
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
                                  state.globalChallengeHeadline,
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.isJoinedCommunityChallenge ? "Status: Engaged & Tracking" : "Status: Open Registration",
                                  style: TextStyle(color: state.isJoinedCommunityChallenge ? const Color(0xFFCCFF00) : Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: viewModel.toggleCommunityChallengeParticipation,
                            style: TextButton.styleFrom(
                              backgroundColor: state.isJoinedCommunityChallenge ? Colors.transparent : const Color(0xFFCCFF00),
                              side: state.isJoinedCommunityChallenge ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              state.isJoinedCommunityChallenge ? "LEAVE" : "JOIN",
                              style: TextStyle(color: state.isJoinedCommunityChallenge ? Colors.grey : Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MealTrackingScreen())).then((_) {
                          viewModel.loadDashboardState();
                        });
                      },
                      icon: const Icon(Icons.restaurant, color: Colors.black, size: 18),
                      label: const Text("OPEN MEAL DIARY LOG", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCCFF00), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutTimerScreen())).then((_) {
                          viewModel.loadDashboardState();
                        });
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