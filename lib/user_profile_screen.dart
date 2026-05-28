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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textLight, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: accent),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: accent,
                    child: const CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/300'), // Placeholder image
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
                  const Text(
                    'PRO MEMBER',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Bio / Info Section
            const Text(
              'BIO',
              style: TextStyle(
                color: mutedOlive,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fitness enthusiast and marathon runner. Focus on strength training and high-intensity interval training.',
              style: TextStyle(color: textLight, fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 32),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('Weight', '64', 'kg'),
                _buildStat('Height', '172', 'cm'),
                _buildStat('Age', '26', 'yo'),
              ],
            ),

            const SizedBox(height: 32),

            // Settings/Options List
            const Text(
              'ACCOUNT SETTINGS',
              style: TextStyle(
                color: mutedOlive,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            _buildProfileOption(Icons.person_outline, 'Personal Information'),
            _buildProfileOption(Icons.notifications_none_rounded, 'Notifications'),
            _buildProfileOption(Icons.security_outlined, 'Security & Privacy'),
            _buildProfileOption(Icons.help_outline_rounded, 'Support Center'),

            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222730),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, String unit) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: mutedOlive, fontSize: 12),
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
                  color: textLight,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(color: accent, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: accent, size: 22),
        title: Text(
          title,
          style: const TextStyle(color: textLight, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right, color: mutedOlive),
        onTap: () {},
      ),
    );
  }
}