import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/exercise_model.dart';
import '../viewmodel/exercise_view_model.dart';
import 'video_screen.dart';
import 'exercise_details_screen.dart';

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
        backgroundColor: Colors.black,
        elevation: 8,
        centerTitle: true,
        title: Text(
          muscleGroup.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFFCCFF00),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final data = exercises[index];
          // Create model instance
          final exercise = Exercise(
            id: data['name']!,
            name: data['name']!,
            image: data['image'] ?? '',
            video: data['video'] ?? '',
            instructions: data['instructions'] ?? '',
            muscle: muscleGroup,
            level: "Intermediate",
            equipment: "N/A",
          );

          return Consumer<ExerciseViewModel>(
            builder: (context, vm, child) {
              final isFavourite = vm.favourites.any((ex) => ex.name == exercise.name);

              return _buildExerciseCard(context, exercise, isFavourite, vm);
            },
          );
        },
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, Exercise exercise, bool isFavourite, ExerciseViewModel vm) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ExerciseDetailsScreen(
              exerciseName: exercise.name,
              muscleGroup: exercise.muscle,
              imagePath: exercise.image,
              instructions: exercise.instructions,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFCCFF00), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCCFF00)),
              ),
              child: Image.asset(exercise.image, fit: BoxFit.cover),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (exercise.video.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => VideoScreen(videoUrl: exercise.video)));
                          }
                        },
                        child: const Row(
                          children: [
                            Text("Play Video", style: TextStyle(color: Color(0xFFCCFF00))),
                            SizedBox(width: 6),
                            Icon(Icons.play_circle_outline, size: 20, color: Color(0xFFCCFF00)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border, color: Colors.redAccent),
                        onPressed: () => vm.toggleFavourite(exercise),
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
}