import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'membership_tracking_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Account state properties
  String athleteName = "FitLog Athlete";
  String athleteEmail = "athlete@fitlog.com";
  double userWeight = 70.0;
  double userHeight = 175.0;

  // Settings switches states
  bool pushNotificationsEnabled = true;
  bool workoutRemindersEnabled = true;
  bool darkModeEnabled = true;
  bool useMetricSystem = true;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      athleteName = prefs.getString('user_name') ?? "FitLog Athlete";
      athleteEmail = prefs.getString('user_email') ?? "athlete@fitlog.com";
      userWeight = prefs.getDouble('user_weight') ?? 70.0;
      userHeight = prefs.getDouble('user_height') ?? 175.0;
      pushNotificationsEnabled = prefs.getBool('setting_push') ?? true;
      workoutRemindersEnabled = prefs.getBool('setting_reminders') ?? true;
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) await prefs.setBool(key, value);
    if (value is double) await prefs.setDouble(key, value);
    if (value is String) await prefs.setString(key, value);
  }

  void _showEditNameDialog() {
    final TextEditingController nameController = TextEditingController(text: athleteName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161616),
        title: const Text("Edit Profile Name", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              setState(() => athleteName = nameController.text.trim());
              _savePreference('user_name', athleteName);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Color(0xFFCCFF00))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        title: const Text("MY PROFILE & SETTINGS", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // PROFILE AVATAR BLOCK
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFCCFF00),
                    child: Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: _showEditNameDialog,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, size: 16, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(athleteName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text(athleteEmail, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 13)),

            const SizedBox(height: 30),

            // SECTION: HEALTH METRICS SUITE
            _buildSectionHeader("BIOMETRIC HEALTH PARAMETERS"),
            _buildSliderTile("Body Mass Weight", userWeight, 40.0, 150.0, useMetricSystem ? "kg" : "lbs", (val) {
              setState(() => userWeight = double.parse(val.toStringAsFixed(1)));
              _savePreference('user_weight', userWeight);
            }),
            _buildSliderTile("Athlete Stature Height", userHeight, 120.0, 220.0, "cm", (val) {
              setState(() => userHeight = double.parse(val.toStringAsFixed(1)));
              _savePreference('user_height', userHeight);
            }),

            const SizedBox(height: 20),

            // SECTION: PREFERENCES & SETTINGS MODULE
            _buildSectionHeader("SYSTEM PREFERENCES & CONTROL"),
            _buildSwitchSettingTile("Push Notification Pipeline", "Receive live dynamic feed pings", pushNotificationsEnabled, (val) {
              setState(() => pushNotificationsEnabled = val);
              _savePreference('setting_push', val);
            }),
            _buildSwitchSettingTile("Workout Window Reminders", "Get alerts near schedule targets", workoutRemindersEnabled, (val) {
              setState(() => workoutRemindersEnabled = val);
              _savePreference('setting_reminders', val);
            }),
            _buildSwitchSettingTile("Metric Measurement Scaling", "Use Kilograms and Centimeters", useMetricSystem, (val) {
              setState(() => useMetricSystem = val);
            }),

            const SizedBox(height: 20),

            // SECTION: UTILITIES & SYSTEM MANAGEMENT
            _buildSectionHeader("UTILITY & ACCOUNT SUBSCRIPTION"),
            _buildStandardActionTile(Icons.card_membership, "Manage FitLog Subscription Plan", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipTrackingScreen()));
            }),
            _buildStandardActionTile(Icons.shield_outlined, "Privacy Policy & Secure Data Protocol", () {}),
            _buildStandardActionTile(Icons.info_outline_rounded, "FitLog Client Engine Version (v1.4.0)", null),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All profile modifications synced securely.")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("SYNC PROFILE PROFILE DATA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(title, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
    );
  }

  Widget _buildSliderTile(String label, double currentVal, double min, double max, String unit, Function(double) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              Text("$currentVal $unit", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: currentVal,
            min: min,
            max: max,
            activeColor: const Color(0xFFCCFF00),
            inactiveColor: Colors.black,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  Widget _buildSwitchSettingTile(String title, String subtitle, bool currentStatus, Function(bool) onToggle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          Switch(
            value: currentStatus,
            activeColor: const Color(0xFFCCFF00),
            activeTrackColor: const Color(0xFFCCFF00).withOpacity(0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.black,
            onChanged: onToggle,
          )
        ],
      ),
    );
  }

  Widget _buildStandardActionTile(IconData icon, String title, VoidCallback? action) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFCCFF00), size: 20),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 13)),
        trailing: action != null ? const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 12) : null,
        onTap: action,
      ),
    );
  }
}