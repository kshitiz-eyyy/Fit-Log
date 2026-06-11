import 'package:flutter/material.dart';
import '../repo/admin_repo_impl.dart';
import '../viewmodel/admin_view_model.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  late final AdminViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AdminViewModel(repository: AdminRepoImpl());
    _viewModel.addListener(_onViewModelUpdate);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) setState(() {});
  }

  Future<void> _saveConfig() async {
    await _viewModel.commitSystemConfiguration();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF161616),
          content: Text(
            "GLOBAL TELEMETRY OVERRIDES DEPLOYED",
            style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00))),
      );
    }

    final state = _viewModel.config;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "CORE ADMIN CONSOLE",
          style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("SYSTEM HEALTH MONITOR", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
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
                      const Text("ACTIVE CONNECTIONS", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${state.simulatedUserCount} Nodes", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const Icon(Icons.dns_outlined, color: Color(0xFFCCFF00), size: 32),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("SYSTEM EMERGENCY NOTICE DISPATCH", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Broadcast Live Alert Notice", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      Switch(
                        value: state.showSystemNoticeAlert,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: _viewModel.toggleShowNotice,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _viewModel.systemNoticeCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: const InputDecoration(
                      labelText: "Notice Dispatch String Content",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("ENTERPRISE FEATURE FLAG OVERRIDES", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enable Video Media Pipeline", style: TextStyle(color: Colors.white, fontSize: 15)),
                      Switch(
                        value: state.enableVideoTutorials,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: _viewModel.toggleVideoTutorials,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Enable Routine Training Splits", style: TextStyle(color: Colors.white, fontSize: 15)),
                      Switch(
                        value: state.enableTrainingSplits,
                        activeColor: const Color(0xFFCCFF00),
                        onChanged: _viewModel.toggleTrainingSplits,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("GLOBAL CHALLENGE BROADCAST", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EDIT ACTIVE CHALLENGE TEXT", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextField(
                    controller: _viewModel.globalChallengeCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF262626))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFCCFF00))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("DATABASE EXERCISE INJECTIONS", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EXERCISE MOVEMENT NAME", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextField(
                    controller: _viewModel.customExerciseNameCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "e.g., Incline Dumbbell Flyes",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text("IMAGE PATH", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextField(
                    controller: _viewModel.exerciseImageCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 14),
                  const Text("VIDEO URL", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextField(
                    controller: _viewModel.exerciseVideoCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 14),
                  const Text("INSTRUCTIONS", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  TextField(
                    controller: _viewModel.exerciseInstructionsCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _viewModel.addNewExerciseInjection,
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text("INJECT INTO LIVE PIPELINE", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFCCFF00),
                            side: const BorderSide(color: Color(0xFFCCFF00)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.delete_sweep, color: Colors.redAccent, size: 26),
                        onPressed: _viewModel.clearAllCustomExercises,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("MEMBERSHIP OVERRIDES", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Force Global Premium Status", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text("Unlocks Pro tiers on all client profiles", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  Switch(
                    value: state.forcePremiumToAll,
                    activeColor: const Color(0xFFCCFF00),
                    onChanged: _viewModel.toggleForcePremium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _saveConfig,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("COMMIT CHANGES SYSTEMWIDE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}