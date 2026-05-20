import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _biometricEnabled = true;
  bool _understandRisks = false;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C0C0C);
    const accentColor = Color(0xFFD4FF00);
    const surfaceColor = Color(0xFF1A1A1A);
    const cardColor = Color(0xFF141414);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E8E);
    const warningColor = Color(0xFFFF5A1F);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF333333)),
                      color: cardColor,
                    ),
                    child: const Icon(Icons.person_outline, color: Colors.grey, size: 24),
                  ),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: textColor, size: 24),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'ATHLETE PROFILE',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'ACCOUNT',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 34,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Member Since\nMAR 2023',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Personal Details Section
                    _buildSectionHeader('PERSONAL DETAILS', 'EDIT ALL', accentColor),
                    const SizedBox(height: 16),
                    _buildDetailCard('FULL NAME', 'Alex Sterling', cardColor),
                    const SizedBox(height: 12),
                    _buildDetailCard('EMAIL ADDRESS', 'a.sterling.performance@forge.com', cardColor),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildStatCard('HEIGHT', '188', 'cm', cardColor)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard('WEIGHT', '92.4', 'kg', cardColor)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard('BODY FAT', '10.2', '%', cardColor)),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Security & Privacy Section
                    const Text(
                      'SECURITY & PRIVACY',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSecurityOption(
                      icon: Icons.lock_outline,
                      title: 'Update Password',
                      cardColor: cardColor,
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 12),
                    _buildSecurityOption(
                      icon: Icons.fingerprint,
                      title: 'Biometric Authentication',
                      cardColor: cardColor,
                      accentColor: accentColor,
                      trailing: Switch(
                        value: _biometricEnabled,
                        onChanged: (val) => setState(() => _biometricEnabled = val),
                        activeThumbColor: Colors.black,
                        activeTrackColor: accentColor,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSecurityOption(
                      icon: Icons.history,
                      title: 'Data Export History',
                      cardColor: cardColor,
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 40),
                    // Terminate Account Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1311),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.warning_amber_rounded, color: warningColor, size: 28),
                              const SizedBox(width: 16),
                              const Text(
                                'TERMINATE\nACCOUNT',
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'This action is permanent and cannot be undone. All workout history, physiological data, and earned badges will be purged from the Forge Performance servers.',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 13,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => setState(() => _understandRisks = !_understandRisks),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFF3A3A3C)),
                                    borderRadius: BorderRadius.circular(4),
                                    color: _understandRisks ? const Color(0xFF3A3A3C) : Colors.transparent,
                                  ),
                                  child: _understandRisks
                                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'I UNDERSTAND THE DATA LOSS RISKS',
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: warningColor),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text(
                                'DELETE ACCOUNT',
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Center(
                            child: Text(
                              'REQUIRES MULTI-FACTOR VERIFICATION',
                              style: TextStyle(
                                color: Color(0xFF48484A),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 4,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dash'),
          const BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Train'),
          const BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Fuel'),
          const BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Goals'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.black),
            ),
            label: 'Admin',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, Color accentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text(
          action,
          style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDetailCard(String label, String value, Color cardColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(unit, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required Color cardColor,
    required Color accentColor,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentColor, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          trailing ?? const Icon(Icons.chevron_right, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
