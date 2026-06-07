import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _activeTab = 0;
  int _totalUsersCount = 1420;
  int _activeProMembers = 385;
  double _serverUptime = 99.98;
  final _challengeNameCtrl = TextEditingController();
  final _newExerciseNameCtrl = TextEditingController();
  String _selectedMuscleGroup = "Chest";

  final List<String> _muscleGroups = ["Chest", "Back", "Legs", "Biceps", "Triceps", "Shoulders", "Abs"];

  final List<Map<String, String>> _registeredUsers = [
    {"name": "Alex Mercer", "email": "alex@fitness.com", "tier": "Pro Premium"},
    {"name": "Sarah Connor", "email": "sarah@terminator.io", "tier": "Free Tier"},
    {"name": "Bruce Wayne", "email": "bruce@gotham.co", "tier": "Pro Premium"},
  ];

  @override
  void initState() {
    super.initState();
    _loadGlobalSystemSettings();
  }

  @override
  void dispose() {
    _challengeNameCtrl.dispose();
    _newExerciseNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadGlobalSystemSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _challengeNameCtrl.text = prefs.getString('admin_global_challenge_name') ?? "Solstice 100k Squat Blast";
    });
  }

  Future<void> _updateBroadcastChallenge() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('admin_global_challenge_name', _challengeNameCtrl.text.trim());

    _showAdminAlert("SYSTEM BROADCAST UPDATE: Parameters synchronized system-wide.");
  }
  void _injectCustomExercise() async {
    String exercise = _newExerciseNameCtrl.text.trim();
    if (exercise.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      List<String> currentExercises = prefs.getStringList('admin_custom_exercises') ?? [];

      currentExercises.add("$exercise|$_selectedMuscleGroup");

      await prefs.setStringList('admin_custom_exercises', currentExercises);

      _showAdminAlert("DATABASE INJECTION: '$exercise' appended to $_selectedMuscleGroup logs.");
      _newExerciseNameCtrl.clear();
    }
  }

  void _showAdminAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF161616),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(side: const BorderSide(color: Color(0xFFCCFF00), width: 0.5), borderRadius: BorderRadius.circular(4)),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFFCCFF00), fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: const Text(
          "SYSTEM CONTROL ROOT",
          style: TextStyle(color: Color(0xFFCCFF00), fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.redAccent, size: 22),
            onPressed: () => Navigator.pop(context), // Route back out to gateway
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF0F0F0F),
            child: Row(
              children: [
                _buildNavTab(0, "OVERVIEW"),
                const SizedBox(width: 6),
                _buildNavTab(1, "DB INJECT"),
                const SizedBox(width: 6),
                _buildNavTab(2, "REGISTRY"),
              ],
            ),
          ),
          const Divider(color: Color(0xFF262626), height: 1, thickness: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _buildActiveViewport(),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildNavTab(int index, String label) {
    final bool isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFCCFF00) : const Color(0xFF161616),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isActive ? const Color(0xFFCCFF00) : const Color(0xFF262626),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveViewport() {
    switch (_activeTab) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("NETWORK INFRASTRUCTURE METRICS", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildStatCard("TOTAL USERS", "$_totalUsersCount", Icons.people_outline)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard("PRO PREMIUM", "$_activeProMembers", Icons.workspace_premium)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard("SYS UPTIME", "$_serverUptime%", Icons.dns_outlined)),
              ],
            ),
            const SizedBox(height: 24),
            const Text("BROADCAST REFRESH (APP ENGINE)", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Global Active Community Challenge", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _challengeNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF262626),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(4)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00), width: 1)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updateBroadcastChallenge,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCFF00),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: const Text("UPDATE NETWORK CONTENT", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("INJECT NEW MOVEMENT RESOURCE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedMuscleGroup,
                    dropdownColor: const Color(0xFF161616),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Target Group Category",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                    ),
                    items: _muscleGroups.map((group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedMuscleGroup = val!),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _newExerciseNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      labelText: "Movement Name (e.g. Incline DB Flyes)",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _injectCustomExercise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFCCFF00)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: const Text("PUSH RAW EXERCISE OBJECT", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("ATHLETE SECURITY REGISTRY MAP", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _registeredUsers.length,
              itemBuilder: (context, index) {
                final user = _registeredUsers[index];
                final isPro = user["tier"] == "Pro Premium";

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user["name"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(user["email"]!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isPro ? const Color(0xFFCCFF00).withOpacity(0.1) : const Color(0xFF262626),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          user["tier"]!.toUpperCase(),
                          style: TextStyle(color: isPro ? const Color(0xFFCCFF00) : Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFCCFF00), size: 16),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}