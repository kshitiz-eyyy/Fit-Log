import 'package:flutter/material.dart';
import 'video_screen.dart';
import 'exercise_data.dart';
import 'favourite_manager.dart'; // ✅ global favourites list

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
        title: Text(muscleGroup.toUpperCase()),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return exerciseCard(exercises[index], context);
        },
      ),
    );
  }
}

// 🔥 Modified exerciseCard widget with favourites
Widget exerciseCard(Map<String, String> data, BuildContext context) {
  bool isFavourite = favouriteExercises.any((ex) => ex["name"] == data["name"]);

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        // 🖼 Fixed-size Image
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: data["image"] != null
              ? Image.asset(
            data["image"]!,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          )
              : const Icon(Icons.fitness_center),
        ),

        const SizedBox(width: 12),

        // 📄 Text + Video Button + Favourite
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
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoScreen(videoUrl: data["video"]!),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Text("Play Video", style: TextStyle(color: Colors.black)),
                        SizedBox(width: 6),
                        Icon(Icons.play_circle_outline,
                            size: 18, color: Colors.black),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (isFavourite) {
                        favouriteExercises.removeWhere(
                                (ex) => ex["name"] == data["name"]);
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
  );
}
