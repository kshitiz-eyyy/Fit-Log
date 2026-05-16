import 'package:flutter/material.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final String exerciseName;
  final String muscleGroup;
  final String imagePath;
  final String instructions;

  const ExerciseDetailsScreen({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
    required this.imagePath,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text(
          exerciseName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼 Exercise Image
            if (imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Icon(Icons.fitness_center, size: 100, color: Colors.white),

            const SizedBox(height: 20),

            // 📝 Instructions
            Text(
              instructions,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // 💪 Muscle Group
            Text(
              "Muscle Group: $muscleGroup",
              style: const TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
