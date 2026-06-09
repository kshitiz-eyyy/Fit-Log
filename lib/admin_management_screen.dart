import 'package:flutter/material.dart';

class AdminManagementScreen extends StatelessWidget {
  const AdminManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cyber-Grid Aesthetic Palette Match
    const bgDark = Color(0xFF0A0A0A);
    const cardDark = Color(0xFF161616);
    const borderDark = Color(0xFF222222);
    const neonLime = Color(0xFFD4FF00);
    const textLight = Colors.white;
    const textMuted = Color(0xFF8E8E93);
    const accentBlue = Color(0xFF007AFF);
    const accentOrange = Color(0xFFFF9500);

    return Scaffold(
      backgroundColor: bgDark,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Control Bar
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: cardDark,
                border: Border(bottom: BorderSide(color: borderDark)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: neonLime, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'FITLOG MANAGEMENT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: textLight,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded, color: textLight),
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: neonLime,
                    child: Icon(Icons.person, color: bgDark, size: 20),
                  ),
                ],
              ),
            ),

            // Scrollable Hub Elements
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Management Hub',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: textLight,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Centralized control for all FitLog ecosystem operations.',
                      style: TextStyle(
                        fontSize: 14,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Card 1: Member Management
                    _ShellCard(
                      card: cardDark,
                      border: borderDark,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0x1A007AFF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.groups_2_outlined, color: accentBlue),
                              ),
                              const Spacer(),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('2,847', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: textLight)),
                                  SizedBox(height: 2),
                                  Text('+12.4%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: neonLime)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Member Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: textLight)),
                          const SizedBox(height: 6),
                          const Text('Handle onboarding, membership tiers, and account lifecycle controls.', style: TextStyle(fontSize: 13, color: textMuted, height: 1.4)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: neonLime,
                                    foregroundColor: bgDark,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text('Add Member', style: TextStyle(fontWeight: FontWeight.w800)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    side: const BorderSide(color: borderDark),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text('View All', style: TextStyle(fontWeight: FontWeight.w700, color: textLight)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 2: System Configuration Status
                    _ShellCard(
                      card: cardDark,
                      border: borderDark,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0x1AFF9500),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.tune_rounded, color: accentOrange),
                              ),
                              const SizedBox(width: 14),
                              const Text('System Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: textLight)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text('Configure platform rules, roles, security policies, and automation defaults.', style: TextStyle(fontSize: 13, color: textMuted, height: 1.4)),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(value: 0.75, minHeight: 6, backgroundColor: borderDark, color: neonLime),
                          ),
                          const SizedBox(height: 8),
                          const Text('75% configured', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: neonLime)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 3: Trainer Directory
                    _ShellCard(
                      card: cardDark,
                      border: borderDark,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.sports_gymnastics_rounded, color: neonLime, size: 24),
                              SizedBox(width: 10),
                              Text('Trainer Records', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: textLight)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('Manage certificates, scheduling rosters, and structural reviews.', style: TextStyle(fontSize: 13, color: textMuted)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Wrap(
                                spacing: -8,
                                children: [
                                  CircleAvatar(radius: 16, backgroundColor: Color(0xFF555555), child: Text('A', style: TextStyle(fontSize: 12, color: textLight))),
                                  CircleAvatar(radius: 16, backgroundColor: Color(0xFF777777), child: Text('R', style: TextStyle(fontSize: 12, color: textLight))),
                                  CircleAvatar(radius: 16, backgroundColor: Color(0xFF222222), child: Text('+8', style: TextStyle(fontSize: 12, color: neonLime))),
                                ],
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text('Open Directory', style: TextStyle(color: neonLime, fontWeight: FontWeight.w700, fontSize: 13)),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward_rounded, color: neonLime, size: 14),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Persistent Navigation Bar Match
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: cardDark,
          border: Border(top: BorderSide(color: borderDark)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.grid_view_rounded, label: 'Dashboard', active: false),
            _NavItem(icon: Icons.people_alt_rounded, label: 'Members', active: true),
            _NavItem(icon: Icons.fitness_center_rounded, label: 'Challenges', active: false),
            //_NavItem(icon: Icons.settings_security_rounded, label: 'Security', active: false),
            _NavItem(icon: Icons.security_rounded, label: 'Security', active: false),
          ],
        ),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: card,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
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
    final color = active ? const Color(0xFFD4FF00) : const Color(0xFF666666);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color, fontWeight: active ? FontWeight.bold : FontWeight.w500),
        ),
      ],
    );
  }
}