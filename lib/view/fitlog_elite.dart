import 'package:flutter/material.dart';

void main() {
  runApp(const FitlogEliteApp());
}

class FitlogEliteApp extends StatelessWidget {
  const FitlogEliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFCCFF00),
          surface: Color(0xFF141414),
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
  int _currentIndex = 0;

  // Set to true for female profile (shows cycle pill) or false for male profile (hides it)
  final bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    const neonColor = Color(0xFFCCFF00);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: neonColor),
          onPressed: () {},
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FITLOG',
              style: TextStyle(
                fontFamily: 'Serif',
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: neonColor,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'ELITE',
              style: TextStyle(
                fontFamily: 'Serif',
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: neonColor,
                letterSpacing: 1.2,
                height: 0.8,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 20, color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Readiness Main Card
            ReadinessCard(isFemale: isFemale),
            const SizedBox(height: 16),

            // 2. Metrics Grid (BMI & Calories)
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    icon: Icons.monitor_weight_outlined,
                    title: 'BODY MASS INDEX',
                    value: '24.2',
                    subtext: 'Athletic\nRange',
                    subtextColor: neonColor,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: MetricCard(
                    icon: Icons.local_fire_department_outlined,
                    title: 'DAILY CALORIES',
                    value: '1,840',
                    subtext: '/ 2,400\nkcal',
                    subtextColor: Colors.grey,
                    progress: 0.76,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Grid Row 2 (Hydration & Training)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.water_drop_outlined, color: neonColor, size: 20),
                        const Text(
                          'HYDRATION',
                          style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '2.4\nLitres',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: neonColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.add, color: Colors.black, size: 28),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.fitness_center, color: neonColor, size: 20),
                            CardTag(label: 'ACTIVE', color: neonColor, textColor: Colors.black),
                          ],
                        ),
                        Text(
                          'TRAINING',
                          style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next: Lower Body\nhypertrophy',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '28 Days Remaining',
                              style: TextStyle(color: neonColor, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 4. Membership Status Card
            const MembershipCard(),
            const SizedBox(height: 32),

            // 5. Quote Section
            const Center(
              child: Column(
                children: [
                  Text(
                    '”',
                    style: TextStyle(color: neonColor, fontSize: 48, fontFamily: 'Serif', height: 0.6),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '"Discipline is the bridge\nbetween goals and\naccomplishment."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontStyle: FontStyle.italic,
                        fontSize: 22,
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '— FITLOG ELITE PROTOCOL',
                    style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF050505),
        selectedItemColor: neonColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Metrics'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- Helper Widget Modules ---

class ReadinessCard extends StatelessWidget {
  final bool isFemale;

  const ReadinessCard({super.key, required this.isFemale});

  @override
  Widget build(BuildContext context) {
    const neonColor = Color(0xFFCCFF00);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  height: 110,
                  width: 110,
                  child: CircularProgressIndicator(
                    value: 0.88,
                    strokeWidth: 6,
                    color: neonColor,
                    backgroundColor: Color(0xFF222222),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('88', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    Text('READINESS', style: TextStyle(fontSize: 9, color: Colors.grey, letterSpacing: 0.5)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Optimal Performance State', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const Text(
            'Your recovery is peaking. Central Nervous\nSystem fatigue is low, and your HRV\nindicates a high capacity for intense\nmetabolic stress today.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 20),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BorderPill(label: 'CNS: FRESH'),
              SizedBox(width: 8),
              BorderPill(label: 'HRV: 94MS'),
            ],
          ),

          if (isFemale) ...[
            const SizedBox(height: 8),
            const BorderPill(label: 'CYCLE: LUTEAL (DAY 18)'),
          ],
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtext;
  final Color subtextColor;
  final double? progress;

  const MetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtext,
    required this.subtextColor,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: const Color(0xFFCCFF00), size: 20),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  subtext,
                  style: TextStyle(color: subtextColor, fontSize: 11, fontWeight: FontWeight.bold, height: 1.1),
                ),
              ),
            ],
          ),
          if (progress != null)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF222222),
              color: const Color(0xFFCCFF00),
              minHeight: 3,
            )
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    const neonColor = Color(0xFFCCFF00);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified_user_outlined, color: neonColor, size: 20),
              SizedBox(width: 8),
              Text(
                'Membership Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TIER', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Fitlog Elite Pro', style: TextStyle(color: neonColor, fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
                Icon(Icons.emoji_events_outlined, color: neonColor, size: 24),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('VALIDITY', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              Text('184 Days Remaining', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.6,
            color: neonColor,
            backgroundColor: Color(0xFF222222),
            minHeight: 4,
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              side: const BorderSide(color: Color(0xFF333333)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: const Text(
              'MANAGE SUBSCRIPTION',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
          )
        ],
      ),
    );
  }
}

class CardTag extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const CardTag({super.key, required this.label, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BorderPill extends StatelessWidget {
  final String label;
  const BorderPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF444444)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}