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
        title: Text(
          "PERFORMANCE LOG HISTORY",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green.shade700,
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
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade800, Colors.green.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          offset: Offset(2, 4)),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(log["icon"], color: Colors.white, size: 36),
                    title: Text(
                      log["title"],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${log["date"]}\nDuration: ${log["duration"]} min • Calories: ${log["calories"]} kcal",
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("PR: ${log["records"]}",
                            style: TextStyle(
                                color: Colors.orangeAccent, fontSize: 14)),
                        Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Weekly Momentum Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade700, Colors.green.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: [
                BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, -4)),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "🔥 Weekly Momentum",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _progressStat("Calories Burned", 1240, Colors.orange),
                    _progressStat("Workouts Done", 4, Colors.lightGreenAccent),
                  ],
                ),
                SizedBox(height: 16),
                Text(
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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center),
      ],
    );
  }
}
