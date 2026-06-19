import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/sleep_view_model.dart';
import '../repo/sleep_repository.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SleepViewModel(repository: SleepRepositoryImpl()),
      child: const _SleepScreenContent(),
    );
  }
}

class _SleepScreenContent extends StatelessWidget {
  const _SleepScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SleepViewModel>();
    final data = viewModel.data;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        title: const Text('FIT LOG AUTOMATION',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSleepProgress(data, viewModel.currentAcceleration),
            const SizedBox(height: 24),
            _buildAutomationStatusBadge(data.isCurrentlyAsleep),
            const SizedBox(height: 12),
            _buildDebugSensorInfo(viewModel.currentAcceleration),
            const SizedBox(height: 32),
            _buildSleepHistoryChart(data.weeklyHistory),
            const SizedBox(height: 24),
            _buildTrackingSection(viewModel),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugSensorInfo(double currentAcceleration) {
    bool isMoving = currentAcceleration > 0.5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SENSOR ACTIVITY",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              Text(
                isMoving ? "MOVING" : "STILL",
                style: TextStyle(
                  color: isMoving ? Colors.orange : Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: (currentAcceleration / 2.0).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(
                isMoving ? Colors.orange : Colors.green),
            minHeight: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSleepProgress(dynamic data, double acceleration) {
    double progressValue = data.lastNightHours / 8.0;
    const Color neonLime = Color(0xFFC6FF00);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: data.isCurrentlyAsleep
                ? null
                : (progressValue > 1.0 ? 1.0 : progressValue),
            strokeWidth: 14,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(neonLime),
            strokeCap: StrokeCap.round,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.isCurrentlyAsleep
                  ? "AUTO-DETECTED: ASLEEP"
                  : "LAST NIGHT'S SLEEP",
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              data.isCurrentlyAsleep ? 'ZzZ' : '${data.lastNightHours}',
              style: const TextStyle(
                color: neonLime,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data.isCurrentlyAsleep ? 'SENSORS ACTIVE' : 'HOURS',
              style: const TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAutomationStatusBadge(bool isAsleep) {
    const Color neonLime = Color(0xFFC6FF00);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: neonLime.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: neonLime.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 16, color: neonLime),
          const SizedBox(width: 8),
          Text(
            isAsleep
                ? 'AUTOMATIC TRACKING IN PROGRESS'
                : 'SMART DETECTION READY',
            style: const TextStyle(
                color: neonLime, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepHistoryChart(List<double> weeklyHistory) {
    const Color neonLime = Color(0xFFC6FF00);
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(weeklyHistory.length, (index) {
          double heightMultiplier =
              weeklyHistory[index] > 1.0 ? 1.0 : weeklyHistory[index];
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 24,
                  height: 100 * heightMultiplier,
                  decoration: BoxDecoration(
                    color: neonLime.withOpacity(0.6),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(days[index],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTrackingSection(SleepViewModel viewModel) {
    final data = viewModel.data;
    const Color neonLime = Color(0xFFC6FF00);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTrackingRow(
            icon: Icons.hdr_auto,
            title: 'Auto Sleep Detection',
            subtitle: 'Uses machine learning & hardware sensors',
            value: data.isAutoTrackingActive,
            onChanged: (val) {
              if (val) {
                viewModel.startTracking();
              } else {
                viewModel.stopTracking();
              }
            },
            activeColor: neonLime,
          ),
          const Divider(color: Colors.white10, height: 32),
          _buildTrackingRow(
            icon: Icons.nightlight_round,
            title: 'Sleep Mode',
            subtitle: 'Automatic silencing',
            value: data.sleepMode,
            onChanged: (val) => viewModel.toggleSleepMode(val),
            activeColor: neonLime,
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: activeColor.withOpacity(0.5),
          activeColor: activeColor,
        ),
      ],
    );
  }
}
