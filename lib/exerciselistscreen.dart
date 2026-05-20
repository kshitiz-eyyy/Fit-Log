import 'package:flutter/material.dart';
import 'video_screen.dart';
import 'exercise_data.dart';
import 'favourite_manager.dart'; // ✅ global favourites list
import 'exercise_details_screen.dart'; // ✅ navigation target

class ExerciseListScreen extends StatelessWidget {
  final String muscleGroup;
  final List<Map<String, String>> exercises;

  const ExerciseListScreen({
    super.key,
    required this.muscleGroup,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCFF00), // ✅ Neon lime accent
        elevation: 8,
        title: Text(
          muscleGroup.toUpperCase(),
          style: const TextStyle(
            color: Colors.black, // better contrast on neon lime
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return exerciseCard(exercises[index], context, muscleGroup);
        },
      ),
    );
  }
}

// 🔥 Fancy exercise card with favourites + video + navigation
Widget exerciseCard(Map<String, String> data, BuildContext context, String muscleGroup) {
  bool isFavourite = favouriteExercises.any((ex) => ex["name"] == data["name"]);

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExerciseDetailsScreen(
            exerciseName: data["name"] ?? "",
            muscleGroup: muscleGroup,
            imagePath: data["image"] ?? "",
            instructions: data.containsKey("instructions") && data["instructions"] != null
                ? data["instructions"]!
                : "No instructions available",
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.black87, Color(0xFF1E1E1E)], // dark gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCCFF00).withOpacity(0.4), // ✅ Neon lime glow
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: const Color(0xFFCCFF00), width: 1.5),
      ),
      child: Row(
        children: [
          // 🖼 Exercise Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCCFF00), width: 1),
            ),
            child: (data["image"] != null && data["image"]!.isNotEmpty)
                ? Image.asset(
              data["image"]!,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            )
                : const Icon(Icons.fitness_center, color: Colors.white),
          ),

          const SizedBox(width: 14),

          // 📄 Text + Video Button + Favourite
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data["reps"] ?? "",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data["video"] != null && data["video"]!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoScreen(videoUrl: data["video"]!),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No video available")),
                          );
                        }
                      },
                      child: Row(
                        children: const [
                          Text("Play Video",
                              style: TextStyle(color: Color(0xFFCCFF00))), // ✅ Neon lime
                          SizedBox(width: 6),
                          Icon(Icons.play_circle_outline,
                              size: 20, color: Color(0xFFCCFF00)), // ✅ Neon lime
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        if (isFavourite) {
                          favouriteExercises.removeWhere((ex) => ex["name"] == data["name"]);
                        } else {
                          favouriteExercises.add(data);
                        }
                        (context as Element).markNeedsBuild(); // refresh UI
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
