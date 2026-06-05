import 'package:flutter/material.dart';

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
                style: TextStyle(color: accent, fontSize: 9.2, fontWeight: FontWeight.w800, letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              const Text(
                'System Performance',
                style: TextStyle(color: textLight, fontSize: 44.8, fontWeight: FontWeight.w800, height: 1),
              ),
              const SizedBox(height: 18),
              Row(
                children: const [
                  Expanded(child: TopButton(text: 'Last 30\nDays', bg: Color(0xFF343941), fg: Color(0xFFD2D3D7), icon: Icons.calendar_today_outlined)),
                  SizedBox(width: 10),
                  Expanded(child: TopButton(text: 'Export\nReport', bg: accent, fg: Color(0xFF121519), icon: Icons.download_rounded)),
                ],
              ),
              const SizedBox(height: 22),
              const MetricCard(icon: Icons.group_outlined, label: 'TOTAL MEMBERS', value: '5,240', badge: '+12.5 %'),
              const SizedBox(height: 16),
              const MetricCard(icon: Icons.fitness_center_rounded, label: 'ACTIVE TRAINERS', value: '12', badge: 'Stable', badgeDark: true),
              const SizedBox(height: 16),
              const MetricCard(icon: Icons.payments_outlined, label: 'MONTHLY REVENUE', value: '\$12.5k', badge: '+8.2k'),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF3A3F2A))),
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Expanded(child: Text('Member Growth', style: TextStyle(color: textLight, fontSize: 21, fontWeight: FontWeight.w700))),
                        Icon(Icons.circle, size: 11, color: accent),
                        SizedBox(width: 8),
                        Text('Active Members', style: TextStyle(color: mutedOlive, fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 26),
                    SizedBox(height: 190, child: CustomPaint(painter: LineChartPainter(), child: SizedBox.expand())),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Month('JAN'), Month('MAR'), Month('MAY'), Month('JUL'), Month('SEP'), Month('NOV')],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: surfaceAlt, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF3A3F2A))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(32, 30, 32, 28),
                      child: Text('Recent Activity', style: TextStyle(color: textLight, fontSize: 21, fontWeight: FontWeight.w700)),
                    ),
                    ActivityTile(icon: Icons.person_add_alt_1, title: 'New Signup: Sarah Miller', subtitle: 'Premium Monthly Plan', time: '2 minutes ago', highlight: true),
                    ActivityTile(icon: Icons.payments_outlined, title: 'Payment Received: \$89.00', subtitle: 'From Marcus Thorne', time: '15 minutes ago', highlight: false),
                    ActivityTile(icon: Icons.person_add_alt_1, title: 'New Signup: David Chen', subtitle: 'Standard Annual Plan', time: '1 hour ago', highlight: true, showBottomBorder: false),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 26),
                      child: Center(child: Text('View All Activity', style: TextStyle(color: Color(0xFFBCBEA7), fontSize: 17.3, fontWeight: FontWeight.w700))),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Divider(color: Color(0xFF2D311E), thickness: 1),
              const SizedBox(height: 24),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 10, color: accent)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'System Status: All Systems Operational\n© 2024 FitTrack Pro Admin Portal, Confidential.',
                      style: TextStyle(color: Color(0xFFCFD0C0), fontSize: 15, height: 1.4, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopButton extends StatelessWidget {
  const TopButton({super.key, required this.text, required this.bg, required this.fg, required this.icon});
  final String text;
  final Color bg;
  final Color fg;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          Icon(icon, color: fg, size: 22),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: fg, fontSize: 13.86, fontWeight: FontWeight.w700, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.icon, required this.label, required this.value, required this.badge, this.badgeDark = false});
  final IconData icon;
  final String label;
  final String value;
  final String badge;
  final bool badgeDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AdminDashboardScreen.cardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x7A000000), blurRadius: 18, offset: Offset(0, 12))],
      ),
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(color: const Color(0xFF171D27), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: const Color(0xFFE6E8EA), size: 26),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: badgeDark ? const Color(0xFF1F252E) : AdminDashboardScreen.accent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badge,
                  style: TextStyle(color: badgeDark ? const Color(0xFFD1CFB2) : const Color(0xFF405300), fontSize: 14.72, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          const SizedBox(height: 28),
          Text(label, style: const TextStyle(color: AdminDashboardScreen.mutedOlive, fontSize: 13.44, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Color(0xFF1D2128), fontSize: 39, fontWeight: FontWeight.w800))
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.icon, required this.title, required this.subtitle, required this.time, required this.highlight, this.showBottomBorder = true});
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool highlight;
  final bool showBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      decoration: BoxDecoration(border: showBottomBorder ? const Border(bottom: BorderSide(color: Color(0xFF2F3421))) : null),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: highlight ? AdminDashboardScreen.accent : const Color(0xFF2D333E),
              shape: BoxShape.circle,
              border: highlight ? null : Border.all(color: const Color(0xFF66721F)),
            ),
            child: Icon(icon, size: 22, color: highlight ? const Color(0xFF182000) : AdminDashboardScreen.accent),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFFE4E5E8), fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(color: Color(0xFF90949D), fontSize: 14.8)),
                const SizedBox(height: 8),
                Text(time, style: const TextStyle(color: AdminDashboardScreen.accent, fontSize: 15.3, fontWeight: FontWeight.w700))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Month extends StatelessWidget {
  const Month(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Color(0xFFB6B99E), fontSize: 15.1, fontWeight: FontWeight.w600));
  }
}

class LineChartPainter extends CustomPainter {
  const LineChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = const Color(0xFF2F3440)..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      final y = size.height * (0.25 + i * 0.18);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final line = Paint()..color = const Color(0xFFC8F500)..strokeWidth = 3..style = PaintingStyle.stroke;
    final glow = Paint()..color = const Color(0x88C8F500)..strokeWidth = 6..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)..style = PaintingStyle.stroke;

    final points = [
      Offset(0, size.height * 0.76),
      Offset(size.width * 0.25, size.height * 0.64),
      Offset(size.width * 0.5, size.height * 0.58),
      Offset(size.width * 0.75, size.height * 0.60),
      Offset(size.width, size.height * 0.44),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final c1 = Offset((current.dx + next.dx) / 2, current.dy);
      final c2 = Offset((current.dx + next.dx) / 2, next.dy);
      path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, next.dx, next.dy);
    }

    canvas.drawPath(path, glow);
    canvas.drawPath(path, line);

    final dot = Paint()..color = const Color(0xFFC8F500);
    final dotWhite = Paint()..color = const Color(0xFFE9FBD0);
    for (final p in points) {
      canvas.drawCircle(p, 3.2, dot);
      canvas.drawCircle(p, 1.5, dotWhite);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

