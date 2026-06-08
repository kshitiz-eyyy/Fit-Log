import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _globalChallengeCtrl = TextEditingController();
  final _systemNoticeCtrl = TextEditingController();

  final _customExerciseNameCtrl = TextEditingController();
  final _exerciseImageCtrl = TextEditingController();
  final _exerciseVideoCtrl = TextEditingController();
  final _exerciseInstructionsCtrl = TextEditingController();

  String _selectedMuscleCategory = "Chest";
  bool _forcePremiumToAll = false;

  bool _enableVideoTutorials = true;
  bool _enableTrainingSplits = true;
  bool _showSystemNoticeAlert = false;

  final int _simulatedUserCount = 1248;
  List<String> _injectedExercisesList = [];

  final List<String> _availableCategories = [
    "Chest", "Back", "Legs", "Biceps", "Triceps", "Shoulders", "Abs"
  ];

  @override
  void initState() {
    super.initState();
    _loadGlobalAdminSettings();
  }

  @override
  void dispose() {
    _globalChallengeCtrl.dispose();
    _systemNoticeCtrl.dispose();
    _customExerciseNameCtrl.dispose();
    _exerciseImageCtrl.dispose();
    _exerciseVideoCtrl.dispose();
    _exerciseInstructionsCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadGlobalAdminSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _globalChallengeCtrl.text = prefs.getString('admin_global_challenge_name') ?? "Solstice 100k Squat Blast";
      _systemNoticeCtrl.text = prefs.getString('admin_system_notice_text') ?? "Scheduled backend database sync at midnight.";
      _forcePremiumToAll = prefs.getBool('admin_force_premium') ?? false;
      _enableVideoTutorials = prefs.getBool('flag_enable_videos') ?? true;
      _enableTrainingSplits = prefs.getBool('flag_enable_splits') ?? true;
      _showSystemNoticeAlert = prefs.getBool('flag_show_notice') ?? false;
      _injectedExercisesList = prefs.getStringList('admin_custom_exercises') ?? [];
    });
  }

  Future<void> _addNewExerciseInjection() async {
    final name = _customExerciseNameCtrl.text.trim();
    final img = _exerciseImageCtrl.text.trim();
    final vid = _exerciseVideoCtrl.text.trim();
    final instructions = _exerciseInstructionsCtrl.text.trim();

    if (name.isEmpty) return;

    final formattedPayload = "$name|$_selectedMuscleCategory|$img|$vid|$instructions";

    setState(() {
      _injectedExercisesList.add(formattedPayload);
      _customExerciseNameCtrl.clear();
      _exerciseImageCtrl.clear();
      _exerciseVideoCtrl.clear();
      _exerciseInstructionsCtrl.clear();
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('admin_custom_exercises', _injectedExercisesList);
  }

  Future<void> _clearAllCustomExercises() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_custom_exercises');
    setState(() {
      _injectedExercisesList.clear();
    });
  }

  Future<void> _saveAdminConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('admin_global_challenge_name', _globalChallengeCtrl.text.trim());
    await prefs.setString('admin_system_notice_text', _systemNoticeCtrl.text.trim());
    await prefs.setBool('admin_force_premium', _forcePremiumToAll);
    await prefs.setBool('flag_enable_videos', _enableVideoTutorials);
    await prefs.setBool('flag_enable_splits', _enableTrainingSplits);
    await prefs.setBool('flag_show_notice', _showSystemNoticeAlert);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF161616),
          content: Text("GLOBAL TELEMETRY OVERRIDES DEPLOYED", style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "CORE ADMIN CONSOLE",
          style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Health Tracker
            const Text("SYSTEM HEALTH MONITOR", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("ACTIVE CONNECTIONS", style: TextStyle(color: Colors.grey, fontSize: 10)),
                      Text("$_simulatedUserCount Nodes", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const Icon(Icons.dns_outlined, color: Color(0xFFCCFF00), size: 28),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Production Global Outbound Banners
            const Text("SYSTEM EMERGENCY NOTICE DISPATCH", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Broadcast Live Alert Notice", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      Switch(
                        value: _showSystemNoticeAlert,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: (val) => setState(() => _showSystemNoticeAlert = val),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _systemNoticeCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: "Notice Dispatch String Content",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 11),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Feature Kill Switches
            const Text("ENTERPRISE FEATURE FLAG OVERRIDES", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enable Video Media Pipeline", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Switch(
                        value: _enableVideoTutorials,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: (val) => setState(() => _enableVideoTutorials = val),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enable Routine Training Splits", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Switch(
                        value: _enableTrainingSplits,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: (val) => setState(() => _enableTrainingSplits = val),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Global Challenge
            const Text("GLOBAL CHALLENGE BROADCAST", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EDIT ACTIVE CHALLENGE TEXT", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  TextField(
                    controller: _globalChallengeCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Exercise Database Injector
            const Text("DATABASE EXERCISE INJECTIONS", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EXERCISE MOVEMENT NAME", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  TextField(
                    controller: _customExerciseNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: "e.g., Incline Dumbbell Flyes",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text("IMAGE PATH", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  TextField(
                    controller: _exerciseImageCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const Text("VIDEO URL", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  TextField(
                    controller: _exerciseVideoCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const Text("INSTRUCTIONS", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  TextField(
                    controller: _exerciseInstructionsCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addNewExerciseInjection,
                          icon: const Icon(Icons.add, size: 14),
                          label: const Text("INJECT INTO LIVE PIPELINE", style: TextStyle(fontSize: 11)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFCCFF00),
                            side: const BorderSide(color: Color(0xFFCCFF00)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
                        onPressed: _clearAllCustomExercises,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Membership Overrides
            const Text("MEMBERSHIP OVERRIDES", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Force Global Premium Status", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      Text("Unlocks Pro tiers on all client profiles", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  Switch(
                    value: _forcePremiumToAll,
                    activeColor: const Color(0xFFCCFF00),
                    onChanged: (val) => setState(() => _forcePremiumToAll = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _saveAdminConfiguration,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("COMMIT CHANGES SYSTEMWIDE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}