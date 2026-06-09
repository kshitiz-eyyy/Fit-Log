import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminDashboardScreen(),
    ),
  );
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF222730);
  static const Color surfaceAlt = Color(0xFF171C24);
  static const Color cardLight = Color(0xFFE9E9EA);
  static const Color accent = Color(0xFFC8F500);
  static const Color mutedOlive = Color(0xFFB7B9A2);
  static const Color textLight = Color(0xFFF3F3F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 22, 30, 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DASHBOARD OVERVIEW',
                style: TextStyle(
                  color: accent,
                  fontSize: 9.2,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'System Performance',
                style: TextStyle(
                  color: textLight,
                  fontSize: 44.8,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: TopButton(
                      text: 'Last 30\nDays',
                      bg: const Color(0xFF343941),
                      fg: const Color(0xFFD2D3D7),
                      icon: Icons.calendar_today_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TopButton(
                      text: 'Export\nReport',
                      bg: accent,
                      fg: const Color(0xFF121519),
                      icon: Icons.download_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              MetricCard(
                icon: Icons.group_outlined,
                label: 'TOTAL MEMBERS',
                value: '5,240',
                badge: '+12.5 %',
              ),

              const SizedBox(height: 16),

              MetricCard(
                icon: Icons.fitness_center_rounded,
                label: 'ACTIVE TRAINERS',
                value: '12',
                badge: 'Stable',
                badgeDark: true,
              ),

              const SizedBox(height: 16),

              MetricCard(
                icon: Icons.payments_outlined,
                label: 'MONTHLY REVENUE',
                value: '\$12.5k',
                badge: '+8.2k',
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3A3F2A)),
                ),
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Member Growth',
                            style: TextStyle(
                              color: textLight,
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(Icons.circle, size: 11, color: accent),
                        SizedBox(width: 8),
                        Text(
                          'Active Members',
                          style: TextStyle(
                            color: mutedOlive,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: 190,
                      child: CustomPaint(
                        painter: LineChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Month('JAN'),
                        Month('MAR'),
                        Month('MAY'),
                        Month('JUL'),
                        Month('SEP'),
                        Month('NOV'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3A3F2A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(32, 30, 32, 28),
                      child: Text(
                        'Recent Activity',
                        style: TextStyle(
                          color: textLight,
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ActivityTile(
                      icon: Icons.person_add_alt_1,
                      title: 'New Signup: Sarah Miller',
                      subtitle: 'Premium Monthly Plan',
                      time: '2 minutes ago',
                      highlight: true,
                    ),
                    ActivityTile(
                      icon: Icons.payments_outlined,
                      title: 'Payment Received: \$89.00',
                      subtitle: 'From Marcus Thorne',
                      time: '15 minutes ago',
                      highlight: false,
                    ),
                    ActivityTile(
                      icon: Icons.person_add_alt_1,
                      title: 'New Signup: David Chen',
                      subtitle: 'Standard Annual Plan',
                      time: '1 hour ago',
                      highlight: true,
                      showBottomBorder: false,
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
}

/* ---------------- SUPPORT WIDGETS ---------------- */

class TopButton extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final IconData icon;

  const TopButton({
    super.key,
    required this.text,
    required this.bg,
    required this.fg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          Icon(icon, color: fg, size: 22),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fg,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String badge;
  final bool badgeDark;

  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.badge,
    this.badgeDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminDashboardScreen.cardLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const Spacer(),
              Text(badge),
            ],
          ),
          const SizedBox(height: 16),
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final bool showBottomBorder;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.highlight,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(time),
    );
  }
}

class Month extends StatelessWidget {
  final String text;
  const Month(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}