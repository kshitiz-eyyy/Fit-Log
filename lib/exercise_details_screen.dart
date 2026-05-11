import 'package:flutter/material.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Exercise Details",
          style: TextStyle(
            color: Colors.lightGreenAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              "Chest",
              style: TextStyle(
                fontSize: 24,
                color: Colors.lightGreenAccent, //
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // Exercise Name
            Text(
              "Bench Press",
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightGreenAccent, //
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16),

            // Illustration
            Center(
              child: Image.asset(
                "assets/images/Benchpress.png",
                height: 200,
              ),
            ),

            SizedBox(height: 24),

            // Instructions
            Text(
              "Instructions:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),

            SizedBox(height: 8),

            InstructionItem("Keep your shoulder blades retracted throughout the lift for better joint stability."),
            InstructionItem("Do not flare your elbows excessively—aim for ~45°–60° from the body."),
            InstructionItem("Maintain a tight glute and leg drive to anchor your base."),
            InstructionItem("Keep wrist alignment neutral to avoid strain."),
            InstructionItem("Lower the bar under control; don’t bounce it off the chest."),
          ],
        ),
      ),
    );
  }
}

// Custom widget for bullet points
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
          Text(
            "• ",
            style: TextStyle(fontSize: 16, color: Colors.white), //
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
