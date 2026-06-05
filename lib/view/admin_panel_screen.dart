import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {

  final _globalChallengeCtrl = TextEditingController();
  bool _forcePremiumToAll = false;
  int _simulatedUserCount = 1248;

  @override
  void initState() {
    super.initState();
    _loadGlobalAdminSettings();
  }

  Future<void> _loadGlobalAdminSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      _globalChallengeCtrl.text = prefs.getString('admin_global_challenge_name') ?? "Solstice 100k Squat Blast";
      _forcePremiumToAll = prefs.getBool('admin_force_premium') ?? false;
    });
  }

  Future<void> _saveAdminConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('admin_global_challenge_name', _globalChallengeCtrl.text.trim());
    await prefs.setBool('admin_force_premium', _forcePremiumToAll);

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