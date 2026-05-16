import 'package:flutter/material.dart';
import 'exercise_details_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final String muscleGroup;
  final List<Map<String, String>> exercises;

  ExerciseListScreen({required this.muscleGroup, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("$muscleGroup Exercises",
            style: TextStyle(color: Colors.lightGreenAccent)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            color: Colors.black,
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(exercise["image"]!, height: 50),
              title: Text(exercise["name"]!,
                  style: TextStyle(fontWeight: FontWeight.bold)),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailsScreen(
                      muscleGroup: muscleGroup,
                      exerciseName: exercise["name"]!,
                      imagePath: exercise["image"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
