import 'package:flutter/material.dart';

class FavouriteExerciseScreen extends StatelessWidget {
  const FavouriteExerciseScreen({super.key});

  final List<Map<String, String>> favouriteExercises = const [
    {
      "name": "Barbell Bench Press",
      "category": "Chest",
      "equipment": "Barbell",
      "level": "Pro"
    },
    {
      "name": "Sumo Deadlift",
      "category": "Posterior Chain",
      "equipment": "Barbell",
      "level": "Elite"
    },
    {
      "name": "Barbell Squat",
      "category": "Legs",
      "equipment": "Barbell",
      "level": "Advanced"
    },
    {
      "name": "Pull-Ups (Weighted)",
      "category": "Back",
      "equipment": "Bodyweight",
      "level": "Pro"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // light background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔝 Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "MY FAVOURITE EXERCISES",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // 📋 Exercise Cards
            Expanded(
              child: ListView.builder(
                itemCount: favouriteExercises.length,
                itemBuilder: (context, index) {
                  final exercise = favouriteExercises[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // ❤️ Favourite Icon
                        const Icon(Icons.favorite, color: Colors.red),

                        const SizedBox(width: 12),

                        // 📄 Exercise Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise["name"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${exercise["category"]} • ${exercise["equipment"]}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              if (exercise["level"]!.isNotEmpty)
                                Text(
                                  "Level: ${exercise["level"]}",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔎 Discover Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "DISCOVER EXERCISES",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            // 📊 Stats Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "MY FAVOURITE EXERCISES",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Saved routines: 04",
                          style: TextStyle(color: Colors.white)),
                      Text("Completion rate: 92%",
                          style: TextStyle(color: Colors.white)),
                      Text("Reps recorded: 18",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            // 🔘 Bottom Navigation
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.home, color: Colors.black),
                  Icon(Icons.library_books, color: Colors.black),
                  Icon(Icons.history, color: Colors.black),
                  Icon(Icons.play_circle_fill, color: Colors.black),
                  Icon(Icons.person, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
