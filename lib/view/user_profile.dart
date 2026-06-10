import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitlog/view/premium_membership.dart';
import 'package:fitlog/view/change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String athleteName = "FitLog Athlete";
  String athleteEmail = "athlete@fitlog.com";
  String athleteBio = "Consistency beats talent every single day.";
  String fitnessGoal = "Hypertrophy Conditioning";
  String? _profileImagePath;

  bool biometricAuthEnabled = false;
  bool pushNotificationsEnabled = true;
  bool workoutRemindersEnabled = true;

  final ImagePicker _picker = ImagePicker();

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
      athleteBio = prefs.getString('user_bio') ?? "Consistency beats talent every single day.";
      fitnessGoal = prefs.getString('fitness_goal') ?? "Hypertrophy Conditioning";
      _profileImagePath = prefs.getString('user_profile_img');

      biometricAuthEnabled = prefs.getBool('setting_biometric') ?? false;
      pushNotificationsEnabled = prefs.getBool('setting_push') ?? true;
      workoutRemindersEnabled = prefs.getBool('setting_reminders') ?? true;
    });
  }

  Future<void> _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) await prefs.setBool(key, value);
    if (value is String) await prefs.setString(key, value);
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) {
        setState(() => _profileImagePath = pickedFile.path);
        await _savePreference('user_profile_img', pickedFile.path);
      }
    } catch (e) {
      _showToastSnackBar("Gallery error: $e");
    }
  }

  void _showEditProfileDialog() {
    final nameCtrl = TextEditingController(text: athleteName);
    final bioCtrl = TextEditingController(text: athleteBio);
    final goalCtrl = TextEditingController(text: fitnessGoal);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161616),
        title: const Text("UPDATE ATHLETE PROFILE", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: goalCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Fitness Goal")),
            TextField(controller: bioCtrl, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Bio Statement")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () async {
              setState(() {
                athleteName = nameCtrl.text.trim();
                athleteBio = bioCtrl.text.trim();
                fitnessGoal = goalCtrl.text.trim();
              });
              await _savePreference('user_name', athleteName);
              await _savePreference('user_bio', athleteBio);
              await _savePreference('fitness_goal', fitnessGoal);
              if (mounted) Navigator.pop(context);
            },
            child: const Text("SAVE", style: TextStyle(color: Color(0xFFCCFF00))),
          )
        ],
      ),
    );
  }

  void _showToastSnackBar(String contextText) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF161616), content: Text(contextText, style: const TextStyle(color: Color(0xFFCCFF00)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFCCFF00),
                    child: CircleAvatar(
                      radius: 47,
                      backgroundColor: const Color(0xFF161616),
                      backgroundImage: _profileImagePath != null ? FileImage(File(_profileImagePath!)) : null,
                      child: _profileImagePath == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFCCFF00),
                    ),
                    icon: const Icon(Icons.photo_camera, size: 18, color: Colors.black),
                    onPressed: _pickProfileImage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(athleteName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(athleteEmail, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text("Goal: $fitnessGoal", textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFCCFF00).withValues(alpha: 0.15))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: const Color(0xFFCCFF00).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.workspace_premium, color: Color(0xFFCCFF00), size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CURRENT SERVICE PLAN", style: TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                            Text("FitLog Pro Premium Access", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF262626), height: 20),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipTrackingScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFCCFF00).withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(4)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings_suggest_outlined, color: Color(0xFFCCFF00), size: 14),
                          SizedBox(width: 6),
                          Text("MANAGE SUBSCRIPTION BILLING", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 10, fontWeight: FontWeight.w900)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCCFF00), size: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("SECURITY & OPERATIONS", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            _buildSwitchTile(Icons.fingerprint, "Biometric Lock", "Verify using facial patterns or touch sensors", biometricAuthEnabled, (val) {
              setState(() => biometricAuthEnabled = val);
              _savePreference('setting_biometric', val);
              _showToastSnackBar(val ? "Simulated Action: Local device biometric authorization checks enabled." : "Simulated Action: Security parameters lifted.");
            }),
            _buildSwitchTile(Icons.notifications_active_outlined, "Push Notifications", "Receive live cloud telemetry updates", pushNotificationsEnabled, (val) {
              setState(() => pushNotificationsEnabled = val);
              _savePreference('setting_push', val);
            }),
            _buildSwitchTile(Icons.alarm, "Workout Reminders", "Get daily reminder alerts for schedules", workoutRemindersEnabled, (val) {
              setState(() => workoutRemindersEnabled = val);
              _savePreference('setting_reminders', val);
            }),
            _buildActionTile(Icons.lock_reset_outlined, "Update Password", "Modify your performance access key", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
            }),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: _showEditProfileDialog,
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey), padding: const EdgeInsets.symmetric(vertical: 12)),
              child: const Text("EDIT METRIC BIO CHANNELS", style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFCCFF00), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ]),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onToggle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFCCFF00), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ]),
          ),
          Switch(value: value, activeThumbColor: const Color(0xFFCCFF00), onChanged: onToggle),
        ],
      ),
    );
  }
}
