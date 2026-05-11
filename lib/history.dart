import 'package:flutter/material.dart';

class PerformanceLogScreen extends StatelessWidget {
  const PerformanceLogScreen({super.key});

  final List<Map<String, String>> workouts = const [
    {
      "title": "UPPER BODY POWER",
      "date": "OCT 24, 2023 - 08:30 AM",
      "duration": "52 MIN",
      "calories": "480 KCAL",
      "completed": "8/8",
      "records": "1 NEW"
    },
    {
      "title": "HIIT INTERVALS",
      "date": "OCT 22, 2023 - 06:15 PM",
      "duration": "35 MIN",
      "calories": "320 KCAL",
      "completed": "",
      "records": ""
    },
    {
      "title": "ACTIVE RECOVERY",
      "date": "OCT 20, 2023 - 07:00 AM",
      "duration": "45 MIN",
      "calories": "150 KCAL",
      "completed": "",
      "records": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ black background
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "FITLOG",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green, // ✅ green title
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PERFORMANCE LOG",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "HISTORY",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              // 📋 Workout List
              Expanded(
                child: ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    return workoutCard(workouts[index]);
                  },
                ),
              ),

              // 📊 Weekly Summary
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // ✅ white card
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "WEEKLY MOMENTUM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("Total Calories Burned: 1,240"),
                    Text("Workouts Done: 4"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔽 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Videos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // 🔥 Workout Card Widget
  Widget workoutCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // ✅ white card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data["title"] ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(data["date"] ?? "",
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Duration: ${data["duration"]}"),
              Text("Burned: ${data["calories"]}"),
            ],
          ),
          if (data["completed"]!.isNotEmpty)
            Text("Exercise Completed: ${data["completed"]}"),
          if (data["records"]!.isNotEmpty)
            Text("Personal Records: ${data["records"]}"),
        ],
      ),
    );
  }
}
