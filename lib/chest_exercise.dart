import 'package:flutter/material.dart';

class ChestExerciseScreen extends StatelessWidget {
  const ChestExerciseScreen({super.key});

  final List<Map<String, String>> exercises = const [
    {
      "name": "Bench Press",
      "reps": "3×12 reps",
      "image": "assets/images/Benchpress.png"
    },
    {
      "name": "Pec Dec Fly",
      "reps": "3×12 reps",
      "image": "assets/images/Pecdecfly.png"
    },
    {
      "name": "Cable Crossover",
      "reps": "3×12 reps",
      "image": "assets/images/cablecrossover.png"
    },
    {
      "name": "Dumbbell Press",
      "reps": "3×12 reps",
      "image": "assets/images/Dumbellpress.png"
    },
    {
      "name": "Machine Press",
      "reps": "3×12 reps",
      "image": "assets/images/machinepress.png"
    },
    {
      "name": "Chest Dips",
      "reps": "3×12 reps",
      "image": "assets/images/chestdips.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9E9486), // brownish background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🔙 Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 10),

              // 🏋️ Title
              const Text(
                "Exercise Lists",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // 🔘 Category Button
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Chest Exercises",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 📋 List
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 🖼 Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: data["image"] != null
                ? Image.asset(data["image"]!, fit: BoxFit.cover)
                : const Icon(Icons.fitness_center),
          ),

          const SizedBox(width: 12),

          // 📄 Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"] ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(data["reps"] ?? ""),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Text("Play Video"),
                    SizedBox(width: 6),
                    Icon(Icons.play_circle_outline, size: 18),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
