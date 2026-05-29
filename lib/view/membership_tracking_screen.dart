import 'package:flutter/material.dart';

class MembershipTrackingScreen extends StatefulWidget {
  const MembershipTrackingScreen({super.key});

  @override
  State<MembershipTrackingScreen> createState() =>
      _MembershipTrackingScreenState();
}

class _MembershipTrackingScreenState extends State<MembershipTrackingScreen> {
  static const Color neon = Color(0xFFD4FF00);


  bool _isBarcodeExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "GYM MEMBERSHIP",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, color: neon, size: 28),
                    onPressed: () {
                      setState(() {
                        _isBarcodeExpanded = !_isBarcodeExpanded;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),


              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: neon, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: neon.withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF1A1A1A),
                        child: Icon(Icons.fitness_center, size: 55, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: neon,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "ELITE MEMBER",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "Rijan Gunda",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Iron Paradise Gym • ID: #98321",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _isBarcodeExpanded ? neon : Colors.white10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isBarcodeExpanded = !_isBarcodeExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.vibration, color: _isBarcodeExpanded ? neon : Colors.white70, size: 24),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Digital Member Pass", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(height: 2),
                                Text("Tap to scan at front desk check-in", style: TextStyle(color: Colors.white54, fontSize: 13)),
                              ],
                            ),
                          ),
                          Icon(
                            _isBarcodeExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white54,
                          ),
                        ],
                      ),
                    ),
                    if (_isBarcodeExpanded) ...[
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(28, (index) {
                                return Container(
                                  width: (index % 3 == 0) ? 6 : (index % 2 == 0) ? 3 : 2,
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                  color: Colors.black,
                                );
                              }),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "* RIJAN-98321-2026 *",
                              style: TextStyle(color: Colors.black54, fontSize: 12, letterSpacing: 2, fontFamily: 'Courier'),
                            )
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),

              const SizedBox(height: 28),


              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: neon, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TIME REMAINING",
                      style: TextStyle(
                        color: neon,
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            "6-Month Full Pass",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: const [
                            Text(
                              "24",
                              style: TextStyle(
                                color: neon,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            Text(
                              "DAYS LEFT",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        value: 0.78,
                        minHeight: 10,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(neon),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Expires: June 22, 2026", style: TextStyle(color: Colors.white54, fontSize: 14)),
                        Text("Active Status", style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),


              const Text(
                "UNLOCKED GYM FEATURES",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.25,
                children: [
                  _buildGymFeatureCard(Icons.all_inclusive, "24/7 Floor Access", "Cardio & Weight Arena"),
                  _buildGymFeatureCard(Icons.lock_open_rounded, "Free Digital Locker", "Secure Locker Assigned"),
                  _buildGymFeatureCard(Icons.people_outline, "2 Guest Passes / Mo", "Bring a workout buddy"),
                  _buildGymFeatureCard(Icons.pool, "Swimming Pool", "Access to Sauna & Pools"),
                  _buildGymFeatureCard(Icons.sports_martial_arts, "Group Classes", "MMA, Yoga & CrossFit"),
                  _buildGymFeatureCard(Icons.bolt, "Recovery Zone", "Massage chairs & Hydro"),
                ],
              ),

              const SizedBox(height: 32),


              const Text(
                "YOUR ASSIGNED COACH",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: neon, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.support_agent, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Coach Alex Mercer",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Specialty: Strength & Conditioning",
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_calendar, color: neon, size: 24),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("✨ Booking request sent to Coach Alex!")),
                        );
                      },
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),


              const Text(
                "GYM MANAGEMENT",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    _buildSettingsTile(
                      icon: Icons.assignment_outlined,
                      title: "Gym Rules & Guidelines",
                      onTap: () => _showGymRulesDialog(context),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.history_toggle_off,
                      title: "Freeze Membership (Max 15 days)",
                      onTap: () => _showFreezeMembershipDialog(context),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.badge_outlined,
                      title: "Upgrade to Platinum Membership",
                      onTap: () => _showUpgradeSheet(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "CAMPUS GYM PROJECT v1.0",
                  style: TextStyle(color: Colors.white24, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGymFeatureCard(IconData icon, String title, String description) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ℹ️ Feature Details: $title is active on your profile.")),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: neon, size: 26),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(description, style: const TextStyle(color: Colors.white54, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Icon(icon, color: Colors.white70, size: 24),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white30),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.white.withValues(alpha: 0.06), height: 1);
  }


  void _showGymRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.gavel, color: neon),
            SizedBox(width: 10),
            Text("Gym Rules & Regulations", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              Text("1. Always re-rack weights after use.", style: TextStyle(color: Colors.white, height: 1.5)),
              SizedBox(height: 8),
              Text("2. Wipe down machinery and benches using sanitizing spray.", style: TextStyle(color: Colors.white, height: 1.5)),
              SizedBox(height: 8),
              Text("3. Appropriate workout attire and closed-toe athletic shoes required.", style: TextStyle(color: Colors.white, height: 1.5)),
              SizedBox(height: 8),
              Text("4. Dropping heavy weights excessively on the non-lifting platform is restricted.", style: TextStyle(color: Colors.white, height: 1.5)),
              SizedBox(height: 8),
              Text("5. Respect other members and share equipment setups during busy hours.", style: TextStyle(color: Colors.white, height: 1.5)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("I Understand", style: TextStyle(color: neon, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }


  void _showFreezeMembershipDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Freeze Membership Plan?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          "This will pause your remaining 24 days left on your active elite pass. You can freeze your account for up to 15 days maximum per term.",
          style: TextStyle(color: Colors.white70, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Go Back", style: TextStyle(color: Colors.white30)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: neon,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("⏸️ Membership frozen successfully! Your days left are now paused.")),
              );
            },
            child: const Text("Confirm Freeze", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }


  void _showUpgradeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Icon(Icons.workspace_premium, color: neon, size: 28),
                SizedBox(width: 10),
                Text("Upgrade to Platinum", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Unlock all city locations, premium private juice lounge bars, free physical massage recovery consults, and priority peak hour booking access.",
              style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("🚀 Upgrade Request sent! Visit reception desk to complete plan switch.")),
                );
              },
              child: const Text("Request Premium Upgrade Pass", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Maybe Later", style: TextStyle(color: Colors.white30)),
            ),
          ],
        ),
      ),
    );
  }
}