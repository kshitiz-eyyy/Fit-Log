import 'package:flutter/material.dart';

class FitnessChallengesScreen extends StatelessWidget {
  const FitnessChallengesScreen({super.key});

  static const Color bg = Color(0xFF070B12);
  static const Color cardDark = Color(0xFF242A33);
  static const Color cardLight = Color(0xFFE9E9EA);
  static const Color lime = Color(0xFFBBF200);
  static const Color text = Color(0xFFF0F1F4);
  static const Color muted = Color(0xFFB7BAA0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 58,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0B1018), Color(0xFF111722)],
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Fit Log',
                            style: TextStyle(
                              color: lime,
                              fontSize: 44 * 0.52,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 25),
                          const SizedBox(width: 14),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF7B8B2D), width: 1),
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=120&h=120&fit=crop'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 22, 22, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Active Challenges', style: TextStyle(color: text, fontSize: 54 * 0.72, fontWeight: FontWeight.w800)),
                          SizedBox(height: 8),
                          Text(
                            'Push your limits and compete with the global\ncommunity.',
                            style: TextStyle(color: Color(0xFFC0C4AB), fontSize: 39 * 0.42, height: 1.45),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      child: PrimaryChallengeCard(),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22, 6, 22, 0),
                      child: RecentBadgesCard(),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22, 16, 22, 0),
                      child: PointsCard(),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22, 16, 22, 0),
                      child: StepsChallengeCard(),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22, 16, 22, 0),
                      child: WeightLossCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 12),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text('Your Trophy Room', style: TextStyle(color: text, fontSize: 42 * 0.58, fontWeight: FontWeight.w700)),
                          ),
                          Text('View All', style: TextStyle(color: lime, fontSize: 35 * 0.45, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22, 4, 22, 22),
                      child: Row(
                        children: [
                          Expanded(child: TrophyCard(icon: Icons.workspace_premium, title: 'Iron Will', subtitle: 'Dec 2023', active: true)),
                          SizedBox(width: 16),
                          Expanded(child: TrophyCard(icon: Icons.military_tech, title: 'Marathoner', subtitle: 'Nov 2023', active: false)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 82,
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1D232C),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(icon: Icons.home_outlined, label: 'Home'),
                  NavPill(icon: Icons.emoji_events_outlined, label: 'Challenges'),
                  NavItem(icon: Icons.auto_graph_outlined, label: 'Progress'),
                  NavItem(icon: Icons.person_outline, label: 'Profile'),
                  NavItem(icon: Icons.settings_outlined, label: 'Settings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryChallengeCard extends StatelessWidget {
  const PrimaryChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: FitnessChallengesScreen.cardLight, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(color: FitnessChallengesScreen.lime, shape: BoxShape.circle),
                child: const Icon(Icons.fitness_center, size: 20, color: Color(0xFF2E3B00)),
              ),
              const SizedBox(width: 10),
              const Text('STRENGTH', style: TextStyle(color: FitnessChallengesScreen.muted, fontSize: 27 * 0.5, fontWeight: FontWeight.w700, letterSpacing: 1)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF141922), borderRadius: BorderRadius.circular(9)),
                child: const Text('PRO CHALLENGE', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('30-Day Pushup\nChallenge', style: TextStyle(color: Color(0xFF1F2329), fontSize: 47 * 0.66, fontWeight: FontWeight.w800, height: 1.1)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.person_outline, color: FitnessChallengesScreen.muted, size: 16),
              SizedBox(width: 6),
              Text('12,430 participants', style: TextStyle(color: FitnessChallengesScreen.muted, fontSize: 29 * 0.45, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: Text('Progress', style: TextStyle(color: Color(0xFF22262D), fontSize: 18 * 1.1, fontWeight: FontWeight.w700))),
              Text('65%', style: TextStyle(color: Color(0xFF4D6800), fontSize: 20 * 1.4, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.65,
              minHeight: 12,
              backgroundColor: Color(0xFFC0C1C4),
              valueColor: AlwaysStoppedAnimation<Color>(FitnessChallengesScreen.lime),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: FitnessChallengesScreen.lime,
                foregroundColor: const Color(0xFF11130E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('View Details', style: TextStyle(fontSize: 21 * 0.9, fontWeight: FontWeight.w700)),
            ),
          )
        ],
      ),
    );
  }
}

class RecentBadgesCard extends StatelessWidget {
  const RecentBadgesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FitnessChallengesScreen.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF495422)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RECENT BADGES', style: TextStyle(color: FitnessChallengesScreen.lime, fontSize: 34 * 0.47, fontWeight: FontWeight.w700, letterSpacing: 1)),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Badge(icon: Icons.emoji_events, label: 'Fast Finisher', active: true),
              Badge(icon: Icons.workspace_premium_outlined, label: '10k Club', active: false),
              Badge(icon: Icons.bolt, label: 'Power Week', active: true),
            ],
          ),
        ],
      ),
    );
  }
}

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: FitnessChallengesScreen.cardLight, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: const Column(
        children: [
          Text('Total Points', style: TextStyle(color: FitnessChallengesScreen.muted, fontSize: 34 * 0.48, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Text('2,450', style: TextStyle(color: Color(0xFF1A1F26), fontSize: 62 * 0.95, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          PillText(text: '+150 this week'),
        ],
      ),
    );
  }
}

class StepsChallengeCard extends StatelessWidget {
  const StepsChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _LightChallengeCard(
      icon: Icons.directions_run,
      tagText: 'Daily',
      tagColor: const Color(0xFF222730),
      title: '10,000 Steps Challenge',
      subtitle: 'Keep the streak alive. 7 days in a row.',
      footerLeft: Row(
        children: [
          ...List.generate(3, (i) {
            return Transform.translate(
              offset: Offset(i == 0 ? 0 : -8.0, 0),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE9E9EA), width: 1.4),
                  image: DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/60?img=${22 + i}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFCBCCCF), borderRadius: BorderRadius.circular(999)),
            child: const Text('+4k', style: TextStyle(fontSize: 11, color: Color(0xFF222730), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      actionLabel: 'Join',
    );
  }
}

class WeightLossCard extends StatelessWidget {
  const WeightLossCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _LightChallengeCard(
      icon: Icons.monitor_weight_outlined,
      tagText: 'Ends in 2d',
      tagColor: const Color(0xFF92000A),
      title: 'Weight Loss Challenge',
      subtitle: 'Personalized milestone tracking for 90\ndays.',
      progress: 0.3,
      footerLeft: const Text('850 active now', style: TextStyle(color: FitnessChallengesScreen.muted, fontSize: 15 * 1.02, fontWeight: FontWeight.w600)),
      actionLabel: 'View',
    );
  }
}

class _LightChallengeCard extends StatelessWidget {
  const _LightChallengeCard({
    required this.icon,
    required this.tagText,
    required this.tagColor,
    required this.title,
    required this.subtitle,
    required this.footerLeft,
    required this.actionLabel,
    this.progress,
  });

  final IconData icon;
  final String tagText;
  final Color tagColor;
  final String title;
  final String subtitle;
  final Widget footerLeft;
  final String actionLabel;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: FitnessChallengesScreen.cardLight, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: const Color(0xFFD2D3D6), borderRadius: BorderRadius.circular(9)),
                child: Icon(icon, color: const Color(0xFF20232A), size: 24),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(6)),
                child: Text(tagText, style: const TextStyle(color: Colors.white, fontSize: 28 * 0.45, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(color: Color(0xFF23272D), fontSize: 43 * 0.61, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(subtitle, style: const TextStyle(color: FitnessChallengesScreen.muted, fontSize: 37 * 0.47, height: 1.4)),
          ),
          if (progress != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFBEBFC3),
                valueColor: const AlwaysStoppedAnimation<Color>(FitnessChallengesScreen.lime),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: footerLeft),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFA8D400), width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  foregroundColor: const Color(0xFF5F7400),
                ),
                child: Text(actionLabel, style: const TextStyle(fontSize: 36 * 0.47, fontWeight: FontWeight.w700)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TrophyCard extends StatelessWidget {
  const TrophyCard({super.key, required this.icon, required this.title, required this.subtitle, required this.active});
  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: const Color(0xFF1E242D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF4B5428)),
      ),
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? FitnessChallengesScreen.lime : const Color(0xFFE9E9EA),
            ),
            child: Icon(icon, color: active ? const Color(0xFF111714) : const Color(0xFF1E2126), size: 34),
          ),
          const SizedBox(height: 14),
          Text(title, style: const TextStyle(color: Color(0xFFE6E7EA), fontSize: 18 * 1.1, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFFB2B5A0), fontSize: 17 * 0.95, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({super.key, required this.icon, required this.label, required this.active});
  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? FitnessChallengesScreen.lime : const Color(0xFF2D323B),
          ),
          child: Icon(icon, size: 30, color: active ? const Color(0xFF233000) : const Color(0xFF8B8E81)),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(color: Color(0xFFD7D8DD), fontSize: 16 * 1.02, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class PillText extends StatelessWidget {
  const PillText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFD4E59D), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Color(0xFF567200), fontSize: 16 * 1.02, fontWeight: FontWeight.w700)),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFC4C6B5), size: 24),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFFC4C6B5), fontSize: 16 * 0.95)),
        ],
      ),
    );
  }
}

class NavPill extends StatelessWidget {
  const NavPill({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 56,
      decoration: BoxDecoration(color: FitnessChallengesScreen.lime, borderRadius: BorderRadius.circular(999)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF2A3108), size: 23),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFF2A3108), fontSize: 16 * 0.95, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
