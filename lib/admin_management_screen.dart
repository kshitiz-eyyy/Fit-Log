import 'package:flutter/material.dart';

class AdminManagementScreen extends StatelessWidget {
  const AdminManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF5F7FB);
    const textDark = Color(0xFF111827);
    const textMuted = Color(0xFF6B7280);
    const card = Colors.white;
    const border = Color(0xFFE5E7EB);
    const blue = Color(0xFF2563EB);
    const orange = Color(0xFFF97316);
    const green = Color(0xFF16A34A);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: border)),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'FitLog Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded, color: textDark),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFDBEAFE),
                    child: Icon(Icons.person, color: blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Management Hub',
                      style: TextStyle(
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Centralized control for all FitTrack Pro ecosystem operations.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.45,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _MemberManagementCard(card: card, border: border, textDark: textDark, textMuted: textMuted, blue: blue),
                    const SizedBox(height: 16),
                    _SystemSettingsCard(card: card, border: border, textDark: textDark, textMuted: textMuted, orange: orange),
                    const SizedBox(height: 16),
                    _TrainerManagementCard(card: card, border: border, textDark: textDark, textMuted: textMuted, green: green),
                    const SizedBox(height: 16),
                    _ChallengeManagementCard(card: card, border: border, textDark: textDark, textMuted: textMuted),
                    const SizedBox(height: 16),
                    _ReportsCard(card: card, border: border, textDark: textDark, textMuted: textMuted, blue: blue),
                    const SizedBox(height: 16),
                    _FooterCard(card: card, border: border, textDark: textDark, textMuted: textMuted, green: green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: border)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(icon: Icons.home_outlined, label: 'Home', active: true),
            _NavItem(icon: Icons.people_outline_rounded, label: 'Members'),
            _NavItem(icon: Icons.fitness_center_rounded, label: 'Trainers'),
            _NavItem(icon: Icons.flag_outlined, label: 'Goals'),
            _NavItem(icon: Icons.bar_chart_outlined, label: 'Reports'),
          ],
        ),
      ),
    );
  }
}

class _MemberManagementCard extends StatelessWidget {
  const _MemberManagementCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.blue,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.groups_2_outlined, color: Color(0xFF2563EB)),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('2,847', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                  SizedBox(height: 4),
                  Text('+12.4%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF16A34A))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Member\nManagement', style: TextStyle(fontSize: 30, height: 1.1, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
          const SizedBox(height: 10),
          Text('Handle onboarding, membership tiers, and account lifecycle controls.', style: TextStyle(fontSize: 14, height: 1.5, color: textMuted)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Add Member', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    side: const BorderSide(color: Color(0xFFBFDBFE)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('View All', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF2563EB))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SystemSettingsCard extends StatelessWidget {
  const _SystemSettingsCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.orange,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;
  final Color orange;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.tune_rounded, size: 34, color: Color(0xFFF97316)),
          ),
          const SizedBox(height: 16),
          const Text('System Settings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
          const SizedBox(height: 8),
          Text('Configure platform rules, roles, security policies, and automation defaults.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, height: 1.4, color: textMuted)),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(value: 0.75, minHeight: 8, backgroundColor: Color(0xFFF3F4F6), color: Color(0xFFF97316)),
          ),
          const SizedBox(height: 10),
          Text('75% configured', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: orange)),
        ],
      ),
    );
  }
}

class _TrainerManagementCard extends StatelessWidget {
  const _TrainerManagementCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.green,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.sports_gymnastics_outlined, color: Color(0xFF16A34A)),
              ),
              const SizedBox(width: 16),
              const Text('Trainer Management', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
            ],
          ),
          const SizedBox(height: 12),
          Text('Manage trainer certifications, session scheduling, and performance reviews.', style: TextStyle(fontSize: 14, height: 1.4, color: textMuted)),
          const SizedBox(height: 16),
          Row(
            children: const [
              CircleAvatar(radius: 20, backgroundColor: Color(0xFFC7D2FE), child: Text('A')),
              SizedBox(width: 8),
              CircleAvatar(radius: 20, backgroundColor: Color(0xFFA7F3D0), child: Text('R')),
              SizedBox(width: 8),
              CircleAvatar(radius: 20, backgroundColor: Color(0xFFFDE68A), child: Text('+8')),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Text('View Trainer Directory', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF16A34A))),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 16, color: Color(0xFF16A34A)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChallengeManagementCard extends StatelessWidget {
  const _ChallengeManagementCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.emoji_events_outlined, color: Color(0xFFD97706)),
          ),
          const SizedBox(height: 10),
          const Text('Challenges', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
          const SizedBox(height: 8),
          Text('Curate monthly fitness goals and seasonal competition leaderboards.', style: TextStyle(fontSize: 14, height: 1.45, color: textMuted)),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(text: 'Monthly Goals'),
              _Tag(text: 'Leaderboards'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportsCard extends StatelessWidget {
  const _ReportsCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.blue,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 49,
            decoration: BoxDecoration(color: const Color(0xFFDBEAFE), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.bar_chart_rounded, color: Color(0xFF2563EB)),
          ),
          const SizedBox(height: 14),
          const Text('Reports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
          const SizedBox(height: 8),
          Text('Financial summaries, user retention graphs, and equipment usage metrics.', style: TextStyle(fontSize: 14, height: 1.5, color: textMuted)),
          const SizedBox(height: 16),
          const SizedBox(
            height: 64,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Bar(height: 26, color: Color(0xFF93C5FD)),
                SizedBox(width: 8),
                _Bar(height: 51, color: Color(0xFF2563EB)),
                SizedBox(width: 8),
                _Bar(height: 32, color: Color(0xFF93C5FD)),
                SizedBox(width: 8),
                _Bar(height: 20, color: Color(0xFF93C5FD)),
                SizedBox(width: 8),
                _Bar(height: 58, color: Color(0xFF2563EB)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterCard extends StatelessWidget {
  const _FooterCard({
    required this.card,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.green,
  });

  final Color card;
  final Color border;
  final Color textDark;
  final Color textMuted;
  final Color green;

  @override
  Widget build(BuildContext context) {
    return _ShellCard(
      card: card,
      border: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('System Status', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Expanded(child: Text('All critical services are operational and synced.', style: TextStyle(fontSize: 14, color: textMuted))),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF111827),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Open Diagnostics Center', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellCard extends StatelessWidget {
  const _ShellCard({required this.child, required this.card, required this.border});

  final Widget child;
  final Color card;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x110F172A), blurRadius: 18, offset: Offset(0, 8)),
        ],
      ),
      child: child,
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF374151), fontWeight: FontWeight.w600)),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.active = false});

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2563EB) : const Color(0xFF9CA3AF);
    return SizedBox(
      width: 68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
