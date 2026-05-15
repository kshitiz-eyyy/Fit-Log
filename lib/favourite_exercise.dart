import 'package:flutter/material.dart';
import 'exerciselistscreen.dart'; // ✅ Import your ExerciseListScreen

class FavouriteExerciseScreen extends StatelessWidget {
  final List<Map<String, String>> exercises = [
    {
      "name": "BARBELL BENCH PRESS",
      "muscle": "Chest",
      "equipment": "Barbell",
      "level": "Advanced",
      "image": "assets/images/benchpress.png",
    },
    {
      "name": "DEADLIFT",
      "muscle": "Posterior Chain",
      "equipment": "Barbell",
      "level": "Elite",
      "image": "assets/images/deadlift.png",
    },
    {
      "name": "SQUAT",
      "muscle": "Legs",
      "equipment": "Barbell",
      "level": "Advanced",
      "image": "assets/images/squats.png",
    },
    {
      "name": "PULL-UPS",
      "muscle": "Back",
      "equipment": "Bodyweight",
      "level": "Pro",
      "image": "assets/images/pullups.png",
    },
    {
      "name": "PEC DEC FLY",
      "muscle": "Chest",
      "equipment": "Machine",
      "level": "Intermediate",
      "image": "assets/images/Pecdecfly.png",
    },
    {
      "name": "CABLE CROSSOVER",
      "muscle": "Chest",
      "equipment": "Cable",
      "level": "Intermediate",
      "image": "assets/images/cablecrossover.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2FF59), // Bright green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "MY FAVOURITE EXERCISES",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Grid layout
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🖼 Exercise Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          exercise["image"]!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.favorite, color: Colors.red),
                            ),
                            Text(
                              exercise["name"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${exercise["muscle"]} • ${exercise["equipment"]}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Level: ${exercise["level"]}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExerciseListScreen(
                          muscleGroup: "Chest",   // or whichever group you want
                          exercises: exercises,
                        ),
                    ),
                );
              },
              child: const Text(
                "DISCOVER EXERCISES",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Saved routines: 06",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
                Text("Completion rate: 92%",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
                Text("Reps recorded: 24",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "LIBRARY"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "HISTORY"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "VIDEO"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
      ),
    );
  }
}
