import 'package:flutter/material.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final String muscleGroup;
  final String exerciseName;
  final String imagePath;

  ExerciseDetailsScreen({
    required this.muscleGroup,
    required this.exerciseName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Exercise Details",
            style: TextStyle(color: Colors.lightGreenAccent)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(muscleGroup,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(exerciseName,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            Center(child: Image.asset(imagePath, height: 200)),
            SizedBox(height: 24),
            Text("Instructions:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent)),
            SizedBox(height: 8),
            InstructionItem("Maintain proper form and controlled movement."),
            InstructionItem("Avoid jerking or swinging the weights."),
            InstructionItem("Focus on muscle contraction and breathing."),
            InstructionItem("Perform 3–4 sets of 10–12 reps."),
          ],
        ),
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  final String text;
  InstructionItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 16, color: Colors.white)),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
