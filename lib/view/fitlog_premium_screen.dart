import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlog/repo/membership_repo_impl.dart';

class FitLogPremiumScreen extends StatefulWidget {
  const FitLogPremiumScreen({super.key});

  @override
  State<FitLogPremiumScreen> createState() => _FitLogPremiumScreenState();
}

class _FitLogPremiumScreenState extends State<FitLogPremiumScreen> {
  static const Color neon = Color(0xFFD4FF00);

  bool _isPremiumCardExpanded = false;
  bool _isPremiumActive = true;
  String _membershipTier = "PREMIUM PRO";
  int _daysLeft = 24;

  int _pdfExportsRemaining = 5;
  bool _cloudBackupSynced = true;
  String _lastBackupTimestamp = "";

  @override
  void initState() {
    super.initState();
    _loadSavedStates();
  }

  Future<void> _loadSavedStates() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final membership = await MembershipRepoImpl().fetchMembership();
      if (mounted) {
        setState(() {
          _membershipTier = membership.tier;
          _isPremiumActive = membership.isActive;
          _daysLeft = membership.daysRemaining;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _membershipTier = prefs.getString('premium_tier') ?? "PREMIUM PRO";
          _isPremiumActive = prefs.getBool('premium_active_state') ?? true;
          _daysLeft = prefs.getInt('premium_days_left') ?? 24;
        });
      }
    }

    if (mounted) {
      setState(() {
        _pdfExportsRemaining = prefs.getInt('pdf_exports_count') ?? 5;
        _cloudBackupSynced = prefs.getBool('cloud_backup_state') ?? true;
        _lastBackupTimestamp = prefs.getString('last_backup_time') ?? "Today, 04:12 AM";
      });
    }
  }

  Future<void> _persistState(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) await prefs.setString(key, value);
    if (value is bool) await prefs.setBool(key, value);
    if (value is int) await prefs.setInt(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final Color tierColor = _membershipTier == "ULTIMATE" ? const Color(0xFF00E5FF) : neon;

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
                  Expanded(
                    child: Text(
                      "FITLOG $_membershipTier",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.workspace_premium, color: tierColor, size: 28),
                    onPressed: () {
                      setState(() {
                        _isPremiumCardExpanded = !_isPremiumCardExpanded;
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
                        border: Border.all(color: tierColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: tierColor.withOpacity(0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF1A1A1A),
                        child: Icon(Icons.bolt, size: 55, color: Colors.white),
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
                        "$_membershipTier ACCOUNT",
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
                      "Kshitiz Pokharel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "FitLog Premium Subscriber • ID: #98321",
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
                  border: Border.all(color: _isPremiumCardExpanded ? tierColor : Colors.white10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isPremiumCardExpanded = !_isPremiumCardExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                              !_isPremiumActive ? Icons.cancel_outlined : Icons.verified_user_rounded,
                              color: !_isPremiumActive ? Colors.redAccent : Colors.greenAccent,
                              size: 24
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    !_isPremiumActive ? "Subscription Inactive" : "FitLog Pro Status Active",
                                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                                ),
                                const SizedBox(height: 2),
                                Text(
                                    !_isPremiumActive ? "Renew parameters to unlock data features" : "Premium engine running & cloud synchronized",
                                    style: const TextStyle(color: Colors.white54, fontSize: 13)
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _isPremiumCardExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white54,
                          ),
                        ],
                      ),
                    ),
                    if (_isPremiumCardExpanded && _isPremiumActive) ...[
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: tierColor.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("CLOUD SYNC LOGS", style: TextStyle(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                Icon(Icons.cloud_done, color: tierColor, size: 14),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text("Database Link: secure_node_#98321", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13, fontFamily: 'Courier')),
                            Text("Last Sync: $_lastBackupTimestamp", style: const TextStyle(color: Colors.white54, fontSize: 11)),
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
                  border: Border.all(color: tierColor, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SUBSCRIPTION TIME REMAINING",
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
                              fontSize: 22,
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
                                color: !_isPremiumActive ? Colors.orangeAccent : tierColor,
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
                        value: !_isPremiumActive ? 0.0 : (_daysLeft / 30.0),
                        minHeight: 10,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(!_isPremiumActive ? Colors.orangeAccent : tierColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Next Billing: July 03, 2026", style: TextStyle(color: Colors.white54, fontSize: 14)),
                        Text(
                            !_isPremiumActive ? "Suspended" : "Active Plan",
                            style: TextStyle(color: !_isPremiumActive ? Colors.orangeAccent : Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "UNLOCKED PREMIUM HUBS",
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
                  _buildFeatureGridItem(
                    icon: Icons.analytics_outlined,
                    title: "Advanced Analytics",
                    description: "Deep fitness trends",
                    isLocked: false,
                    themeColor: tierColor,
                    onTap: () => _showFeatureAccessAlert("Advanced Analytics Engine", "Your macro consistency charts and performance tracking predictions have been completely evaluated for this month."),
                  ),
                  _buildFeatureGridItem(
                    icon: Icons.photo_library_outlined,
                    title: "Transformation Vault",
                    description: "Unlimited progress logs",
                    isLocked: _membershipTier != "ULTIMATE",
                    themeColor: tierColor,
                    onTap: _handleTransformationFeatureTap,
                  ),
                  _buildFeatureGridItem(
                    icon: Icons.picture_as_pdf_outlined,
                    title: "$_pdfExportsRemaining PDF Reports Left",
                    description: "Export fitness history",
                    isLocked: false,
                    themeColor: tierColor,
                    onTap: _handlePdfReportExportTap,
                  ),
                  _buildFeatureGridItem(
                    icon: Icons.track_changes_outlined,
                    title: "Goal Prediction",
                    description: "Smart progress forecasting",
                    isLocked: _membershipTier != "ULTIMATE",
                    themeColor: tierColor,
                    onTap: () => _showFeatureAccessAlert("AI Goal Prediction", "Based on your logged workout vectors, your target metrics parameters are forecasted to hit 100% completion in 42 days!"),
                  ),
                  _buildFeatureGridItem(
                    icon: Icons.workspace_premium_outlined,
                    title: "Achievement Vault",
                    description: "Premium badges & rewards",
                    isLocked: false,
                    themeColor: tierColor,
                    onTap: _showPremiumAchievementsDialog,
                  ),
                  _buildFeatureGridItem(
                    icon: Icons.rocket_launch_outlined,
                    title: "Early Access",
                    description: "Try new features first",
                    isLocked: false,
                    themeColor: tierColor,
                    onTap: () => _showFeatureAccessAlert("Early Access Channels", "You have direct optimization clearance to test upcoming Wearable Smartwatch synchronization hooks ahead of standard users."),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                "PREMIUM PLAN STATUS",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () => _showPremiumMetricsDialog(context),
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
                          child: Icon(Icons.stars, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "FitLog Pro Architecture Plan",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Click to view telemetry & bill properties",
                              style: TextStyle(color: Colors.white54, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.receipt_long, color: tierColor, size: 24)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "SUBSCRIPTION MANAGEMENT",
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
                      icon: Icons.cloud_sync,
                      title: "Force Data Cloud Backup",
                      onTap: () => _handleCloudSyncTask(),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.history_toggle_off,
                      title: !_isPremiumActive ? "Resume Premium Engine" : "Pause Subscription Tracking",
                      onTap: () => _togglePremiumActiveStatus(),
                    ),
                    _buildDivider(),
                    _buildSettingsTile(
                      icon: Icons.badge_outlined,
                      title: _membershipTier == "ULTIMATE" ? "Downgrade to Standard Pro" : "Claim Code: Upgrade to Ultimate Tier",
                      onTap: () => _showUpgradeSheet(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "FITLOG PREMIUM v1.0 • POWERED BY AI",
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

  Widget _buildFeatureGridItem({
    required IconData icon,
    required String title,
    required String description,
    required bool isLocked,
    required Color themeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isLocked ? Colors.redAccent.withOpacity(0.2) : Colors.white10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: isLocked ? Colors.white24 : themeColor, size: 26),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: isLocked ? Colors.white30 : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(color: isLocked ? Colors.white24 : Colors.white54, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (isLocked)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.lock_outline, color: Colors.redAccent, size: 16),
              ),
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
    return Divider(color: Colors.white.withOpacity(0.06), height: 1);
  }

  void _showFeatureAccessAlert(String featureName, String accessInstructions) {
    if (_membershipTier != "ULTIMATE" && (featureName.contains("Vault") || featureName.contains("Prediction"))) {
      _showPremiumLockWarning(featureName);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(featureName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(accessInstructions, style: const TextStyle(color: Colors.white70, height: 1.4)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Got It", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPremiumLockWarning(String featureName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.lock, color: Colors.redAccent),
            SizedBox(width: 10),
            Text("Access Restricted", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          "$featureName is a standalone strategic vector restricted to ULTIMATE tier members. Upgrade your account structural parameter matrix to deploy this module.",
          style: const TextStyle(color: Colors.white70, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Dismiss", style: TextStyle(color: Colors.white30)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showUpgradeSheet(context);
            },
            child: const Text("Upgrade Plan", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _handleTransformationFeatureTap() {
    if (_membershipTier != "ULTIMATE") {
      _showPremiumLockWarning("Transformation Gallery Vault");
      return;
    }
    _showFeatureAccessAlert("Transformation Log Matrix", "Access authenticated. Secure camera sandbox initialized for uploading multi-angle physiological tracking assets.");
  }

  void _handlePdfReportExportTap() {
    if (_pdfExportsRemaining <= 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Limits Reached", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text("Your monthly allocation quota parameters for physical PDF telemetry documents has run empty."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Dismiss", style: TextStyle(color: Colors.white30))),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Export PDF Progress File", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text("Generate compiled analytics report now? This task will consume 1 document point from your database matrix. (Available tokens: $_pdfExportsRemaining)"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () {
              setState(() {
                _pdfExportsRemaining--;
              });
              _persistState('pdf_exports_count', _pdfExportsRemaining);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("📄 PDF report generated & cached! Remaining balance: $_pdfExportsRemaining"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Compile Document", style: TextStyle(color: neon, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPremiumAchievementsDialog() {
    final List<String> syntheticAchievements = [
      "🔥 30-Day Activity Streak — Unlocked",
      "🏋️ 100 Finished Workouts — Unlocked",
      "🚀 Micro-target Completion Bonus — Active"
    ];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Premium Achievements", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: syntheticAchievements.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.stars, color: neon, size: 20),
                title: Text(syntheticAchievements[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Back", style: TextStyle(color: Colors.white30)),
          ),
        ],
      ),
    );
  }

  void _togglePremiumActiveStatus() {
    setState(() {
      _isPremiumActive = !_isPremiumActive;
    });
    _persistState('premium_active_state', _isPremiumActive);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(!_isPremiumActive
            ? "⏸️ Subscription data pipelines paused. Feature checks restricted."
            : "⚡ FitLog Premium systems restored successfully!"),
        backgroundColor: !_isPremiumActive ? Colors.orangeAccent : Colors.green,
      ),
    );
  }

  void _handleCloudSyncTask() {
    final nowTime = "Just Now";
    setState(() {
      _cloudBackupSynced = true;
      _lastBackupTimestamp = nowTime;
    });
    _persistState('cloud_backup_state', true);
    _persistState('last_backup_time', nowTime);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("☁️ Remote sync pipeline triggered. User records mirrored to cloud schema."),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showUpgradeSheet(BuildContext context) {
    final textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _membershipTier == "ULTIMATE" ? "DOWNGRADE TIERS" : "UPGRADE TO ULTIMATE TIER",
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _membershipTier == "ULTIMATE"
                  ? "Enter the validation string 'PRO' to reset back to basic tracking properties."
                  : "Enter the code 'ULTIMATE' to activate transformation galleries and goal prediction engines.",
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter configuration code...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: neon),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final input = textController.text.trim().toUpperCase();
                if (input == "ULTIMATE" && _membershipTier != "ULTIMATE") {
                  setState(() {
                    _membershipTier = "ULTIMATE";
                  });
                  _persistState('premium_tier', "ULTIMATE");
                  Navigator.pop(context);
                  _showFeatureAccessAlert("Upgrade Authorized", "Account configuration modified to ULTIMATE tier. Data galleries are now operational.");
                } else if (input == "PRO" && _membershipTier == "ULTIMATE") {
                  setState(() {
                    _membershipTier = "PREMIUM PRO";
                  });
                  _persistState('premium_tier', "PREMIUM PRO");
                  Navigator.pop(context);
                  _showFeatureAccessAlert("Downgraded", "Returned account tracing nodes back to Standard Pro specifications.");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ Invalid tier parameter override token.")),
                  );
                }
              },
              child: const Text("SUBMIT CORE OVERRIDE", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showPremiumMetricsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("FitLog Pro License", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Subscription Model: SaaS Digital Pass", style: TextStyle(color: neon, fontSize: 13, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Secure Node Pipeline status: Authenticated & operating via active user context.", style: TextStyle(color: Colors.white70, fontSize: 13)),
            SizedBox(height: 12),
            Text("Next Automatic Audit Cycle: June 22, 2026", style: TextStyle(color: Colors.white30, fontSize: 11)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}