import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitlog/view/fitlog_premium_screen.dart';
import 'package:fitlog/view/change_password_screen.dart';
import '../viewmodel/user_profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileViewModel _viewModel = UserProfileViewModel();
  final ImagePicker _picker = ImagePicker();
  final _goalInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelStateUpdated);
    _viewModel.fetchLiveProfileData();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelStateUpdated);
    _goalInputController.dispose();
    super.dispose();
  }

  void _onViewModelStateUpdated() {
    if (mounted) setState(() {});
  }

  Future<void> _handleImageSelectionFlow() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) {
        await _viewModel.updatePreferenceSetting('user_profile_img', pickedFile.path);
      }
    } catch (e) {
      _showToastSnackBar("Gallery error: $e");
    }
  }

  void _executeNewGoalCommit() async {
    final text = _goalInputController.text;
    if (text.trim().isEmpty) return;

    try {
      await _viewModel.addNewFitnessGoal(text);
      _goalInputController.clear();
      FocusScope.of(context).unfocus();
      _showToastSnackBar("New fitness parameter locked into database.");
    } catch (e) {
      _showDiagnosticErrorDialog(
          "Cloud Connection Blocked",
          "The database rejected the write request.\n\nError: $e"
      );
    }
  }

  void _showEditProfileDialog() {
    final nameCtrl = TextEditingController(text: _viewModel.athleteName);
    final bioCtrl = TextEditingController(text: _viewModel.athleteBio);
    final goalCtrl = TextEditingController(text: _viewModel.fitnessGoal);

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
              try {
                await _viewModel.saveProfileChanges(
                  name: nameCtrl.text.trim(),
                  bio: bioCtrl.text.trim(),
                  fitnessGoal: goalCtrl.text.trim(),
                );
                _showToastSnackBar("Cloud Database Profile synchronized successfully.");
              } catch (e) {
                _showToastSnackBar("Cloud push failure point: ${e.toString()}");
              }
              if (mounted) Navigator.pop(context);
            },
            child: const Text("SAVE", style: TextStyle(color: Color(0xFFCCFF00))),
          )
        ],
      ),
    );
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

  void _showToastSnackBar(String contextText) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF161616), content: Text(contextText, style: const TextStyle(color: Color(0xFFCCFF00)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: _viewModel.isDataSyncLoading
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
                      backgroundImage: _viewModel.profileImagePath != null ? FileImage(File(_viewModel.profileImagePath!)) : null,
                      child: _viewModel.profileImagePath == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: const Color(0xFFCCFF00)),
                    icon: const Icon(Icons.photo_camera, size: 18, color: Colors.black),
                    onPressed: _handleImageSelectionFlow,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(_viewModel.athleteName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(_viewModel.athleteEmail, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text("Goal: ${_viewModel.fitnessGoal}", textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 11)),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(_viewModel.athleteBio, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic)),
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
                            Text(_viewModel.membershipPlanText, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
                    onPressed: _executeNewGoalCommit,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_viewModel.getCurrentUserId())
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
                              onPressed: () async {
                                try {
                                  await _viewModel.markGoalAsCompleted(doc.id);
                                  _showToastSnackBar("Objective achieved! Progress entry synchronized.");
                                } catch (e) {
                                  _showToastSnackBar("Error updating achievement status: $e");
                                }
                              },
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
            _buildSwitchTile(Icons.fingerprint, "Biometric Lock", "Verify using facial patterns or touch sensors", _viewModel.biometricAuthEnabled, (val) {
              _viewModel.updatePreferenceSetting('setting_biometric', val);
              _showToastSnackBar(val ? "Simulated Action: Local device biometric authorization checks enabled." : "Simulated Action: Security parameters lifted.");
            }),
            _buildSwitchTile(Icons.notifications_active_outlined, "Push Notifications", "Receive live cloud telemetry updates", _viewModel.pushNotificationsEnabled, (val) {
              _viewModel.updatePreferenceSetting('setting_push', val);
            }),
            _buildSwitchTile(Icons.alarm, "Workout Reminders", "Get daily reminder alerts for schedules", _viewModel.workoutRemindersEnabled, (val) {
              _viewModel.updatePreferenceSetting('setting_reminders', val);
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