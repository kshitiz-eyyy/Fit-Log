import 'package:flutter/material.dart';

void main() {
  runApp(const FitLogApp());
}

class FitLogApp extends StatelessWidget {
  const FitLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFCCFF00),
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFCCFF00);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: accentColor),
          onPressed: () {},
        ),
        title: const Text(
          'FITLOG',
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 1.5,
            fontFamily: 'Serif',
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- READINESS CARD ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.88,
                          strokeWidth: 8,
                          color: accentColor,
                          backgroundColor: Colors.white10,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '88',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'READINESS',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Optimal Performance State',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your recovery is peaking. Central Nervous System fatigue is low, and your HRV indicates a high capacity for intense metabolic stress today.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMetricBadge('CNS: FRESH'),
                      const SizedBox(width: 10),
                      _buildMetricBadge('HRV: 94MS'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildMetricBadge('SLEEP: 92%'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- FIXED METRICS ROW 1 ---
            Row(
              children: [
                Expanded(
                  child: _buildGridCard(
                    icon: Icons.assignment,
                    title: 'BODY MASS INDEX',
                    value: '24.2',
                    subtitle: 'Athletic Range',
                    subtitleColor: accentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildGridCard(
                    icon: Icons.local_fire_department,
                    title: 'DAILY CALORIES',
                    value: '1,840',
                    subtitle: '/ 2,400 kcal',
                    hasProgressBar: true,
                    progressValue: 1840 / 2400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- FIXED METRICS ROW 2 ---
            Row(
              children: [
                Expanded(
                  child: _buildGridCard(
                    icon: Icons.opacity,
                    title: 'HYDRATION',
                    value: '2.4',
                    subtitle: 'Liters',
                    extraWidget: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.add, color: Colors.black, size: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildGridCard(
                    icon: Icons.fitness_center,
                    title: 'TRAINING',
                    value: 'ACTIVE',
                    isValueBadge: true,
                    subtitle: 'Next: Lower Body\n28 Days Remaining',
                    subtitleColor: accentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- MEMBERSHIP STATUS CARD ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.shield_outlined, color: accentColor, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Membership Status',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25), // Modern .withValues fix
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('TIER', style: TextStyle(color: Colors.grey, fontSize: 10)),
                            SizedBox(height: 4),
                            Text(
                              'FitLog Elite Pro',
                              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const Icon(Icons.workspace_premium, color: accentColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('VALIDITY', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text('184 Days Remaining', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    value: 0.6,
                    color: accentColor,
                    backgroundColor: Colors.white10,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'MANAGE SUBSCRIPTION',
                        style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- QUOTE SECTION ---
            const Icon(Icons.format_quote, color: accentColor, size: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                '"Discipline is the bridge between goals and accomplishment."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
            const Text(
              '— FITLOG ELITE PROTOCOL',
              style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.5),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Metrics'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper Widget for Badges (CNS, HRV, Sleep)
  Widget _buildMetricBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  // Helper Widget for Grid Cards
  Widget _buildGridCard({
    required IconData icon,
    required String title,
    required String value,
    bool isValueBadge = false,
    required String subtitle,
    Color subtitleColor = Colors.grey,
    bool hasProgressBar = false,
    double progressValue = 0.0,
    Widget? extraWidget,
  }) {
    const accentColor = Color(0xFFCCFF00);
    return Container(
      height: 165,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: accentColor, size: 20),
              if (extraWidget != null) extraWidget, // Optimized inline element rule syntax
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (isValueBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(4)),
              child: Text(value, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
            )
          else
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          const SizedBox(height: 8),
          if (hasProgressBar) ...[
            LinearProgressIndicator(
              value: progressValue,
              color: accentColor,
              backgroundColor: Colors.white10,
            ),
            const SizedBox(height: 6),
          ],
          Text(
            subtitle,
            style: TextStyle(color: subtitleColor, fontSize: 11, height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}