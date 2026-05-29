import 'package:flutter/material.dart';

class MembershipTrackingScreen extends StatefulWidget {
  const MembershipTrackingScreen({super.key});

  @override
  State<MembershipTrackingScreen> createState() =>
      _MembershipTrackingScreenState();
}

class _MembershipTrackingScreenState extends State<MembershipTrackingScreen> {
  static const Color neon = Color(0xFFD4FF00);

  /// Dynamic App States (This makes it fully functional)
  bool _isBarcodeExpanded = false;
  bool _isFrozen = false;
  bool _isCheckedIn = false;
  String _membershipTier = "ELITE";
  int _daysLeft = 24;

  @override
  Widget build(BuildContext context) {
    // Dynamically update UI assets based on upgraded state
    final Color tierColor = _membershipTier == "PLATINUM" ? const Color(0xFF00E5FF) : neon;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP NAVIGATION BAR
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "$_membershipTier MEMBERSHIP",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: tierColor, size: 28),
                    onPressed: () {
                      setState(() {
                        _isBarcodeExpanded = !_isBarcodeExpanded;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// MEMBER INFORMATION CARD
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: tierColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: tierColor.withValues(alpha: 0.3),
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
                        color: tierColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "$_membershipTier MEMBER",
                        style: const TextStyle(
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

              /// DIGITAL CHECK-IN PASS (Workable Functional State Modification)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _isBarcodeExpanded ? tierColor : Colors.white10),
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
                          Icon(
                              _isFrozen ? Icons.block : (_isCheckedIn ? Icons.check_circle : Icons.vibration),
                              color: _isFrozen ? Colors.redAccent : (_isCheckedIn ? Colors.greenAccent : Colors.white70),
                              size: 24
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _isFrozen ? "Pass Suspended (Frozen)" : (_isCheckedIn ? "Checked In Successfully" : "Digital Member Pass"),
                                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                                ),
                                const SizedBox(height: 2),
                                Text(
                                    _isFrozen ? "Unfreeze account to scan doors" : (_isCheckedIn ? "Enjoy your workout session!" : "Tap to scan at front desk check-in"),
                                    style: const TextStyle(color: Colors.white54, fontSize: 13)
                                ),
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
                    if (_isBarcodeExpanded && !_isFrozen) ...[
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isCheckedIn = !_isCheckedIn;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isCheckedIn ? "✅ Welcome to Iron Paradise! Check-in logged." : "🔄 Attendance reset simulation."),
                              backgroundColor: _isCheckedIn ? Colors.green : Colors.grey[800],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _isCheckedIn ? Colors.greenAccent : Colors.transparent, width: 2)
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
                                    color: _isCheckedIn ? Colors.green[900] : Colors.black,
                                  );
                                }),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _isCheckedIn ? "TAP TO RESET SIMULATION" : "* RIJAN-98321-2026 *",
                                style: TextStyle(
                                    color: _isCheckedIn ? Colors.green[700] : Colors.black54,
                                    fontSize: 12,
                                    letterSpacing: 2,
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// MEMBERSHIP COUNTDOWN CARD (Reacts directly to local state modifications)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: tierColor, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TIME REMAINING",
                      style: TextStyle(
                        color: tierColor,
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "6-Month $_membershipTier Pass",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            Text(
                              "$_daysLeft",
                              style: TextStyle(
                                color: _isFrozen ? Colors.orangeAccent : tierColor,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            const Text(
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
                      child: LinearProgressIndicator(
                        value: _isFrozen ? 1.0 : (_daysLeft / 30.0),
                        minHeight: 10,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(_isFrozen ? Colors.orangeAccent : tierColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Expires: June 22, 2026", style: TextStyle(color: Colors.white54, fontSize: 14)),
                        Text(
                            _isFrozen ? "Paused / Frozen" : "Active Status",
                            style: TextStyle(color: _isFrozen ? Colors.orangeAccent : Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 32),

              /// WHAT YOU GET WITH THIS MEMBERSHIP
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
                  _buildGymFeatureCard(Icons.all_inclusive, "24/7 Floor Access", "Cardio & Weight Arena", tierColor),
                  _buildGymFeatureCard(Icons.lock_open_rounded, "Free Digital Locker", "Secure Locker Assigned", tierColor),
                  _buildGymFeatureCard(Icons.people_outline, "2 Guest Passes / Mo", "Bring a workout buddy", tierColor),
                  _buildGymFeatureCard(Icons.pool, "Swimming Pool", "Access to Sauna & Pools", tierColor),
                  _buildGymFeatureCard(Icons.sports_martial_arts, "Group Classes", "MMA, Yoga & CrossFit", tierColor),
                  _buildGymFeatureCard(Icons.bolt, "Recovery Zone", "Massage chairs & Hydro", tierColor),
                ],
              ),

              const SizedBox(height: 32),

              /// ASSIGNED PERSONAL TRAINER SECTION (Now fully functional on click)
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
              InkWell(
                onTap: () => _showTrainerDetailsDialog(context),
                borderRadius: BorderRadius.circular(24),
                child: Container(
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
                        decoration: BoxDecoration(color: tierColor, shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white),
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
                              "Click to see metrics & contact file",
                              style: TextStyle(color: Colors.white54, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.contact_phone, color: tierColor, size: 24)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// GYM MANAGEMENT PANEL
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
                      onTap: () => _showGymRulesDialog(context, tierColor),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.history_toggle_off,
                      title: _isFrozen ? "Resume Membership Status" : "Freeze Membership (Max 15 days)",
                      onTap: () => _toggleFreezeStatus(),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.badge_outlined,
                      title: _membershipTier == "PLATINUM" ? "Downgrade to Standard Elite" : "Upgrade to Platinum Membership",
                      onTap: () => _showUpgradeSheet(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "CAMPUS GYM PROJECT v2.0 (LIVE)",
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

  Widget _buildGymFeatureCard(IconData icon, String title, String description, Color themeColor) {
    return Container(
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
          Icon(icon, color: themeColor, size: 26),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(description, style: const TextStyle(color: Colors.white54, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
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

  /// 1. WORKABLE ACTION: CHANGER OF FREEZE STATE
  void _toggleFreezeStatus() {
    setState(() {
      _isFrozen = !_isFrozen;
      if (_isFrozen) {
        _isBarcodeExpanded = false; // Close barcode if frozen
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFrozen ? "⏸️ Membership Frozen. Countdown suspended." : "▶️ Membership Resumed! Active pass restored."),
        backgroundColor: _isFrozen ? Colors.orange[800] : Colors.green[800],
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
              children: [
                Icon(Icons.workspace_premium, color: _membershipTier == "ELITE" ? const Color(0xFF00E5FF) : neon, size: 28),
                const SizedBox(width: 10),
                Text(
                    _membershipTier == "ELITE" ? "Upgrade to Platinum" : "Downgrade to Elite",
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _membershipTier == "ELITE"
                  ? "Unlock premium blue neon design modifications, private lounge spaces, and full spa access."
                  : "Return back to the high-performance standard neon package dashboard plan options.",
              style: const TextStyle(color: Colors.white54, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _membershipTier == "ELITE" ? const Color(0xFF00E5FF) : neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                setState(() {
                  _membershipTier = _membershipTier == "ELITE" ? "PLATINUM" : "ELITE";
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("🚀 Account structural upgrade changed to $_membershipTier!"),
                    backgroundColor: Colors.indigo,
                  ),
                );
              },
              child: Text(
                  _membershipTier == "ELITE" ? "Confirm Platinum Switch" : "Confirm Standard Switch",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Dismiss", style: TextStyle(color: Colors.white30)),
            ),
          ],
        ),
      ),
    );
  }

  /// 3. WORKABLE TRAINER DETAILS DISPLAY (Requested Implementation)
  void _showTrainerDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white12,
              child: Icon(Icons.support_agent, size: 45, color: neon),
            ),
            const SizedBox(height: 16),
            const Text(
              "Coach Alex Mercer",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Senior Health Specialist",
              style: TextStyle(color: neon, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white12),
            const SizedBox(height: 10),

            // Dynamic Key Value Display rows
            _buildTrainerInfoRow(Icons.person_outline, "Trainer Name", "Rijan Gunda"),
            _buildTrainerInfoRow(Icons.phone_android, "Contact Number", "+977 9841-XXXXXX"),
            _buildTrainerInfoRow(Icons.workspace_premium, "Certification Type", "ISSA Certified Master Coach"),
            _buildTrainerInfoRow(Icons.fitness_center, "Specialization", "Hypertrophy & Bodybuilding"),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, size: 18),
              label: const Text("Close Profile File"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white30, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 4. VIEW POPUP LIST OF GYM RULES
  void _showGymRulesDialog(BuildContext context, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.gavel, color: themeColor),
            const SizedBox(width: 10),
            const Text("Gym Regulations", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              Text("• Always re-rack structural free weights.", style: TextStyle(color: Colors.white, height: 1.6)),
              Text("• Wipe down machinery surfaces after use.", style: TextStyle(color: Colors.white, height: 1.6)),
              Text("• Athletic closed-toe shoes must be worn.", style: TextStyle(color: Colors.white, height: 1.6)),
              Text("• Respect personal coach booking time-slots.", style: TextStyle(color: Colors.white, height: 1.6)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Dismiss Guidelines", style: TextStyle(color: themeColor, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}