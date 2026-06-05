import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _activeTab = 0;
  final int _totalUsersCount = 1420;
  final int _activeProMembers = 385;
  final double _serverUptime = 99.98;

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
        backgroundColor: const Color(0xFF050508).withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFCCFF00), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Row(
              children: [
                const Icon(Icons.data_object, color: Color(0xFFCCFF00), size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color(0xFFCCFF00),
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060608),
      body: Stack(
        children: [
          // Cyberpunk Background Subtle Ambient Orbs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFCCFF00).withOpacity(0.03),

              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Custom Header Matrix
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "CORE CONTROL NODE",
                            style: TextStyle(
                              color: Color(0xFFCCFF00),
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "SECURE ROOT SESSION ACTIVE",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_fullscreen_rounded, color: Colors.redAccent, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.06),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          side: BorderSide(color: Colors.redAccent.withOpacity(0.2), width: 0.5),
                        ),
                      )
                    ],
                  ),
                ),

                const Divider(color: Color(0xFF161622), height: 1),

                // Main Workspace Layout
                Expanded(
                  child: Row(
                    children: [
                      // Sidebar Navigation Rail Menu
                      Container(
                        width: 76,
                        decoration: const BoxDecoration(
                          border: Border(right: BorderSide(color: Color(0xFF161622), width: 1)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildSidebarItem(0, Icons.grid_view_rounded, "DASH"),
                            _buildSidebarItem(1, Icons.terminal_rounded, "INJECT"),

                          ],
                        ),
                      ),

                      // Primary Workspace Content Dynamic Stream Viewport
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _buildActiveViewport(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String microLabel) {
    final bool isActive = _activeTab == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 52,
          height: 56,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFCCFF00) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [BoxShadow(color: const Color(0xFFCCFF00).withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 2))]
                : [],
            border: Border.all(
              color: isActive ? const Color(0xFFCCFF00) : const Color(0xFF161622),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.black : Colors.grey.shade500,
                size: 18,
              ),
              const SizedBox(height: 3),
              Text(
                microLabel,
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.grey.shade600,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveViewport() {
    switch (_activeTab) {
      case 0:
        return Column(
          key: const ValueKey(0),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionLabel("TELEMETRY STREAM"),
            const SizedBox(height: 12),
            _buildStatCard("TOTAL RUNTIME USERS", "$_totalUsersCount", Icons.people_outline, Colors.cyanAccent),
            const SizedBox(height: 12),
            _buildStatCard("ACTIVE PREMIUM TIERS", "$_activeProMembers", Icons.workspace_premium, const Color(0xFFCCFF00)),
            const SizedBox(height: 12),
            _buildStatCard("BACKEND CORE UPTIME", "$_serverUptime%", Icons.dns_outlined, Colors.purpleAccent),
            const SizedBox(height: 32),

            _buildSectionLabel("BROADCAST NETWORK CONFIG"),
            const SizedBox(height: 12),
            _buildGlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Global Community Event Header", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _challengeNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'monospace'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF1F1F2E)), borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFCCFF00)), borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updateBroadcastChallenge,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCFF00),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("BROADCAST PARAMS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1)),
                  ),
                ],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionLabel("RESOURCE DATABASE INJECTION"),
            const SizedBox(height: 12),
            _buildGlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedMuscleGroup,
                    dropdownColor: const Color(0xFF0D0D12),
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Target Classification Mapping",
                      labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                      filled: true,
                      fillColor: const Color(0xFF0F0F14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF1F1F2E)), borderRadius: BorderRadius.circular(6)),
                    ),
                    items: _muscleGroups.map((group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedMuscleGroup = val!),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _newExerciseNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      labelText: "Target Resource Identifier String",
                      labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                      hintText: "Ex: Kettlebell Clean & Press",
                      hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                      filled: true,
                      fillColor: const Color(0xFF0F0F14),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF1F1F2E)), borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFCCFF00)), borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: _injectCustomExercise,
                    icon: const Icon(Icons.add_to_photos_rounded, size: 14),
                    label: const Text("EXECUTE DICTIONARY INJECTION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFCCFF00),
                      side: const BorderSide(color: Color(0xFFCCFF00), width: 1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          key: const ValueKey(2),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionLabel("RUNTIME SECURITY USER PROTOCOLS"),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _registeredUsers.length,
              itemBuilder: (context, index) {
                final user = _registeredUsers[index];
                final isPro = user["tier"] == "Pro Premium";

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF1A1A26)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user["name"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 2),
                            Text(user["email"]!, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontFamily: 'monospace')),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isPro ? const Color(0xFFCCFF00).withOpacity(0.05) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isPro ? const Color(0xFFCCFF00).withOpacity(0.3) : Colors.grey.shade800,
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          user["tier"]!.toUpperCase(),
                          style: TextStyle(
                            color: isPro ? const Color(0xFFCCFF00) : Colors.grey.shade500,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 9,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
        fontFamily: 'monospace',
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color dynamicAccent) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1A1A26)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: dynamicAccent.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: dynamicAccent.withOpacity(0.15), width: 0.5),
            ),
            child: Icon(icon, color: dynamicAccent, size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassPanel({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1A1A26)),
      ),
      child: child,
    );
  }
}