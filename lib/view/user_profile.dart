import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlog/view/fitlog_premium_screen.dart';
import 'package:fitlog/view/change_password_screen.dart';
import 'fitlog_premium_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String athleteName = "Loading Athlete...";
  String athleteEmail = "athlete@fitlog.com";
  String athleteBio = "Consistency beats talent every single day.";
  String fitnessGoal = "Hypertrophy Conditioning";
  String membershipPlanText = "FitLog Regular Member";
  String? _profileImagePath;

  bool biometricAuthEnabled = false;
  bool pushNotificationsEnabled = true;
  bool workoutRemindersEnabled = true;
  bool _isDataSyncLoading = true;

  final ImagePicker _picker = ImagePicker();

  // Controller to handle the text input for new objectives
  final _goalInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLiveFirebaseProfileData();
  }

  @override
  void dispose() {
    _goalInputController.dispose();
    super.dispose();
  }

  // Helper method to reliably get the current user ID
  String _getCurrentUserId() {
    User? liveFirebaseUser = FirebaseAuth.instance.currentUser;
    if (liveFirebaseUser != null) {
      return liveFirebaseUser.uid;
    }
    return "Eb3LsmAGcqNpd5pfwO28TpPyFWL2";
  }

  Future<void> _fetchLiveFirebaseProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _profileImagePath = prefs.getString('user_profile_img');
        biometricAuthEnabled = prefs.getBool('setting_biometric') ?? false;
        pushNotificationsEnabled = prefs.getBool('setting_push') ?? true;
        workoutRemindersEnabled = prefs.getBool('setting_reminders') ?? true;
      });

      String targetUid = _getCurrentUserId();
      User? liveFirebaseUser = FirebaseAuth.instance.currentUser;

      setState(() {
        athleteEmail = liveFirebaseUser?.email ?? "kritikatripathi0094@gmail.com";
      });

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(targetUid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          athleteName = data['name'] ?? "Kritika Tripathi";
          athleteBio = data['user_bio'] ?? "Consistency beats talent every single day.";
          fitnessGoal = data['fitness_goal'] ?? "Hypertrophy Conditioning";

          String systemRole = data['role'] ?? 'user';
          membershipPlanText = systemRole == 'admin'
              ? "FitLog System Administrator"
              : "FitLog Pro Premium Access";
        });
      }
    } catch (e) {
      debugPrint("Profile data pipeline sync telemetry failure: $e");
    } finally {
      setState(() => _isDataSyncLoading = false);
    }
  }

  // --- SAVE DYNAMIC FITNESS GOAL DATA COLLECTION ---
  Future<void> _addNewFitnessGoal(String goalTitle) async {
    if (goalTitle.trim().isEmpty) return;

    // Use reliable target ID fallback mapping
    String targetUid = _getCurrentUserId();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(targetUid)
          .collection('fitness_goals')
          .add({
        'goal_title': goalTitle.trim(),
        'status': 'active',
        'created_at': FieldValue.serverTimestamp(),
        'completed_at': null,
      });

      _goalInputController.clear();

      // Close software keyboard out of view automatically
      FocusScope.of(context).unfocus();
      _showToastSnackBar("New fitness parameter locked into database.");
    } catch (e) {
      debugPrint("FIRESTORE SUBCOLLECTION ERROR: $e");
      _showDiagnosticErrorDialog(
          "Cloud Connection Blocked",
          "The database rejected the write request.\n\nError: $e\n\nFix: Check your Cloud Firestore 'Rules' tab and ensure they allow reads and writes."
      );
    }
  }

  Future<void> _markGoalAsCompleted(String docId) async {
    String targetUid = _getCurrentUserId();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(targetUid)
          .collection('fitness_goals')
          .doc(docId)
          .update({
        'status': 'completed',
        'completed_at': FieldValue.serverTimestamp(),
      });
      _showToastSnackBar("Objective achieved! Progress entry synchronized.");
    } catch (e) {
      _showToastSnackBar("Error updating achievement status: $e");
    }
  }

  void _showDiagnosticErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161616),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 20),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
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
              final newName = nameCtrl.text.trim();
              final newBio = bioCtrl.text.trim();
              final newGoal = goalCtrl.text.trim();

              setState(() {
                athleteName = newName;
                athleteBio = newBio;
                fitnessGoal = newGoal;
                _isDataSyncLoading = true;
              });

              try {
                String targetUid = _getCurrentUserId();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(targetUid)
                    .update({
                  'name': newName,
                  'user_bio': newBio,
                  'fitness_goal': newGoal,
                });

                await _savePreference('user_name', newName);
                await _savePreference('user_bio', newBio);
                await _savePreference('fitness_goal', newGoal);

                _showToastSnackBar("Cloud Database Profile synchronized successfully.");
              } catch (e) {
                _showToastSnackBar("Cloud push failure point: ${e.toString()}");
              } finally {
                setState(() => _isDataSyncLoading = false);
              }

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
    String currentUserId = _getCurrentUserId();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: _isDataSyncLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00)))
          : SingleChildScrollView(
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
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(athleteBio, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic)),
            ),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("CURRENT SERVICE PLAN", style: TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                            Text(membershipPlanText, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF262626), height: 20),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FitLogPremiumScreen())),
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
            const Text("TARGET MILESTONES & GOALS", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _goalInputController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: "Add customized milestone target...",
                        hintStyle: TextStyle(color: Colors.white24, fontSize: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Color(0xFFCCFF00)),
                    onPressed: () => _addNewFitnessGoal(_goalInputController.text),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUserId)
                  .collection('fitness_goals')
                  .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("No custom milestones set yet.", style: TextStyle(color: Colors.white24, fontSize: 11)),
                  );
                }

                return Column(
                  children: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final isCompleted = data['status'] == 'completed';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isCompleted ? Colors.black : const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(4),
                        border: isCompleted ? null : Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: isCompleted ? const Color(0xFFCCFF00) : Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              data['goal_title'] ?? '',
                              style: TextStyle(
                                color: isCompleted ? Colors.white30 : Colors.white,
                                fontSize: 13,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                          if (!isCompleted)
                            TextButton(
                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
                              onPressed: () => _markGoalAsCompleted(doc.id),
                              child: const Text("COMPLETE", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 10, fontWeight: FontWeight.bold)),
                            )
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
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