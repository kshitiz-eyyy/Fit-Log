import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "PERFORMANCE LOG HISTORY",
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWorkoutCard(
            title: "Upper Body Power",
            date: "October 24, 2023 - 08:30 AM",
            duration: "52 minutes",
            calories: "480 kcal",
            exercises: "8/8",
            records: "2 new",
            progress: 1.0,
          ),
          _buildWorkoutCard(
            title: "HIIT Intervals",
            date: "October 22, 2023 - 06:15 PM",
            duration: "35 minutes",
            calories: "320 kcal",
            progress: 0.7,
          ),
          _buildWorkoutCard(
            title: "Active Recovery",
            date: "October 20, 2023 - 07:00 AM",
            duration: "45 minutes",
            calories: "150 kcal",
            progress: 0.4,
          ),
          const SizedBox(height: 20),
          _buildWeeklyMomentum(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        currentIndex: 2, // History tab highlighted
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Videos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          // TODO: Add navigation logic
        },
      ),
    );
  }

  Widget _buildWorkoutCard({
    required String title,
    required String date,
    required String duration,
    required String calories,
    double progress = 0.0,
    String? exercises,
    String? records,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center, color: Colors.yellow, size: 28),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ],
            ),
            const SizedBox(height: 4),
            Text(date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text("Duration: $duration", style: const TextStyle(color: Colors.white)),
            Text("Calories: $calories", style: const TextStyle(color: Colors.white)),
            if (exercises != null)
              Text("Exercises: $exercises", style: const TextStyle(color: Colors.white)),
            if (records != null)
              Text("Personal Records: $records", style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[700],
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyMomentum() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text("Weekly Momentum",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            SizedBox(height: 8),
            Text("🔥 Total Calories Burned: 1240",
                style: TextStyle(color: Colors.black)),
            Text("🏋️ Workouts Done: 4",
                style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
