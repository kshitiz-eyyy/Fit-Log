import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Reusing your defined colors
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF222730);
  static const Color accent = Color(0xFFC8F500);
  static const Color textLight = Color(0xFFF3F3F3);
  static const Color mutedOlive = Color(0xFFB7B9A2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        // Changed to check if it can pop to prevent black screen errors
        leading: Navigator.canPop(context)
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textLight, size: 20),
          onPressed: () => Navigator.pop(context),
        )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: accent),
            onPressed: () {
              // Add edit logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Added for smoother scrolling on iOS/Web
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: accent,
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sarah Miller',
                    style: TextStyle(
                      color: textLight,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PRO MEMBER',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Bio Section
            const _SectionHeader(title: 'BIO'),
            const SizedBox(height: 8),
            const Text(
              'Fitness enthusiast and marathon runner. Focus on strength training and high-intensity interval training.',
              style: TextStyle(
                color: textLight,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 32),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _StatCard(label: 'Weight', value: '64', unit: 'kg'),
                _StatCard(label: 'Height', unit: 'cm', value: '172'),
                _StatCard(label: 'Age', value: '26', unit: 'yo'),
              ],
            ),

            const SizedBox(height: 32),

            // Settings/Options List
            const _SectionHeader(title: 'ACCOUNT SETTINGS'),
            const SizedBox(height: 16),

            const _ProfileOption(icon: Icons.person_outline, title: 'Personal Information'),
            const _ProfileOption(icon: Icons.notifications_none_rounded, title: 'Notifications'),
            const _ProfileOption(icon: Icons.security_outlined, title: 'Security & Privacy'),
            const _ProfileOption(icon: Icons.help_outline_rounded, title: 'Support Center'),

            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: surface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Add logout logic here
                },
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// Sub-widget for Section Headers to reduce repetition
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: ProfileScreen.mutedOlive,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }
}

// Sub-widget for Stats to improve performance
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95, // Slightly smaller to ensure fit on all screens
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: ProfileScreen.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: ProfileScreen.mutedOlive, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: ProfileScreen.textLight,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(color: ProfileScreen.accent, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Sub-widget for Profile Options
class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileOption({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ProfileScreen.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: ProfileScreen.accent, size: 22),
        title: Text(
          title,
          style: const TextStyle(
            color: ProfileScreen.textLight,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: ProfileScreen.mutedOlive, size: 20),
        onTap: () {},
      ),
    );
  }
}