import 'package:flutter/material.dart';

class ChestExerciseScreen extends StatelessWidget {
  const ChestExerciseScreen({super.key});

  final List<Map<String, String>> exercises = const [
    {
      "name": "Bench Press",
      "reps": "4×8 reps",
      "image": "assets/images/Benchpress.png"
    },
    {
      "name": "Dumbbell Press",
      "reps": "3×12 reps",
      "image": "assets/images/Dumbellpress.png"
    },
    {
      "name": "Cable Crossover",
      "reps": "3×15 reps",
      "image": "assets/images/cablecrossover.png"
    },
    {
      "name": "Pec Dec Fly",
      "reps": "3×12 reps",
      "image": "assets/images/Pecdecfly.png"
    },
    {
      "name": "Chest Dips",
      "reps": "3×Failure",
      "image": "assets/images/chestdips.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E), // ✅ brown background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "CHEST EXERCISES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.lightGreenAccent,
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
                "CHEST / PECTORALS",
                style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return exerciseCard(exercises[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Exercise Card Widget
  Widget exerciseCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black, // ✅ white card background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white

                .withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🖼 Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              data["image"]!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          // 📄 Text + Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data["reps"] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add video navigation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // ✅ green button
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.play_circle_fill,
                      size: 18, color: Colors.black),
                  label: const Text(
                    "PLAY VIDEO",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
