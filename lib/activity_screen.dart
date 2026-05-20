import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  final List<Map<String, dynamic>> logs = [
    {
      "title": "Upper Body Power",
      "date": "October 24, 2023 - 08:30 AM",
      "duration": 52,
      "calories": 480,
      "exercises": "8/8",
      "records": "2 new",
      "icon": Icons.fitness_center,
    },
    {
      "title": "HIIT Intervals",
      "date": "October 20, 2023 - 06:15 PM",
      "duration": 35,
      "calories": 320,
      "exercises": "6/6",
      "records": "1 new",
      "icon": Icons.flash_on,
    },
    {
      "title": "Active Recovery",
      "date": "October 20, 2023 - 07:00 AM",
      "duration": 45,
      "calories": 150,
      "exercises": "5/5",
      "records": "0",
      "icon": Icons.self_improvement,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "PERFORMANCE LOG HISTORY",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFFCCFF00), // ✅ Neon lime accent
        centerTitle: true,
        elevation: 8,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E1E1E), Color(0xFF121212)], // dark gradient
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFCCFF00).withOpacity(0.4), // ✅ Neon lime glow
                          blurRadius: 8,
                          offset: const Offset(2, 4)),
                    ],
                    border: Border.all(color: const Color(0xFFCCFF00), width: 1.5),
                  ),
                  child: ListTile(
                    leading: Icon(log["icon"], color: const Color(0xFFCCFF00), size: 36), // ✅ Neon lime icon
                    title: Text(
                      log["title"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${log["date"]}\nDuration: ${log["duration"]} min • Calories: ${log["calories"]} kcal",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("PR: ${log["records"]}",
                            style: const TextStyle(
                                color: Colors.orangeAccent, fontSize: 14)),
                        const Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Weekly Momentum Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF121212), Color(0xFF1E1E1E)], // dark gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: [
                const BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, -4)),
              ],
              border: Border.all(color: const Color(0xFFCCFF00), width: 1.5),
            ),
            child: Column(
              children: [
                const Text(
                  "🔥 Weekly Momentum",
                  style: TextStyle(
                      color: Color(0xFFCCFF00), // ✅ Neon lime accent
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _progressStat("Calories Burned", 1240, Colors.orange),
                    _progressStat("Workouts Done", 4, const Color(0xFFCCFF00)), // ✅ Neon lime accent
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Keep pushing! You're unstoppable 💪",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressStat(String label, int value, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: 0.8,
                strokeWidth: 8,
                color: color,
                backgroundColor: Colors.white24,
              ),
            ),
            Text(
              "$value",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center),
      ],
    );
  }
}
