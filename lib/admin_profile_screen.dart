import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF222730);
  static const Color surfaceAlt = Color(0xFF171C24);
  static const Color accent = Color(0xFFC8F500);
  static const Color textLight = Color(0xFFF3F3F3);
  static const Color muted = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: accent,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Admin User",
                      style: TextStyle(
                        color: textLight,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "System Administrator",
                      style: TextStyle(
                        color: muted,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit Profile"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Personal Information
              _sectionCard(
                title: "Personal Information",
                children: const [
                  ProfileTile(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: "admin@fitlog.com",
                  ),
                  ProfileTile(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    value: "+977 98XXXXXXXX",
                  ),
                  ProfileTile(
                    icon: Icons.location_on_outlined,
                    title: "Location",
                    value: "Kathmandu, Nepal",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Statistics
              _sectionCard(
                title: "Admin Statistics",
                children: const [
                  ProfileTile(
                    icon: Icons.people_outline,
                    title: "Total Members Managed",
                    value: "5,240",
                  ),
                  ProfileTile(
                    icon: Icons.fitness_center_outlined,
                    title: "Active Trainers",
                    value: "12",
                  ),
                  ProfileTile(
                    icon: Icons.attach_money,
                    title: "Monthly Revenue",
                    value: "\$12.5K",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Settings
              _sectionCard(
                title: "Settings",
                children: [
                  SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.security_outlined,
                    title: "Privacy & Security",
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceAlt,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: textLight,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: AdminProfileScreen.accent,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: AdminProfileScreen.accent,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white70,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
