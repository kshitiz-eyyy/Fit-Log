import 'package:flutter/material.dart';
import 'video_screen.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final String exerciseName;
  final String muscleGroup;
  final String imagePath;
  final String instructions;
  final String? videoUrl;

  const ExerciseDetailsScreen({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
    required this.imagePath,
    required this.instructions,
    this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCFF00), // ✅ Neon lime accent
        elevation: 12,
        title: Text(
          exerciseName,
          style: const TextStyle(
            color: Colors.black, // better contrast on neon lime
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF003300)], // black → deep green
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🖼 Exercise Image with glow
              if (imagePath.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCCFF00).withOpacity(0.6), // ✅ Neon lime glow
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagePath,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                const Icon(Icons.fitness_center,
                    size: 120, color: Colors.white),

              const SizedBox(height: 28),

              // 📝 Rich Description Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFCCFF00), width: 2), // ✅ Neon lime border
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCCFF00).withOpacity(0.4), // ✅ Neon lime glow
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection("Overview",
                        "This exercise builds strength and definition in your $muscleGroup, improving both aesthetics and performance."),
                    _buildSection("Muscles Worked",
                        "Primary: $muscleGroup\nSecondary: Shoulders, core, stabilizers."),
                    _buildSection("Step-by-Step Guide",
                        "1) Get into starting position.\n2) Perform the movement slowly.\n3) Focus on form.\n4) Complete recommended reps."),
                    _buildSection("Breathing Technique",
                        "Inhale during the lowering phase, exhale during the lifting phase."),
                    _buildSection("Common Mistakes",
                        "• Rushing the movement\n• Using momentum\n• Poor posture"),
                    _buildSection("Pro Tips",
                        "• Keep core tight\n• Control every rep\n• Focus on muscle contraction"),
                    _buildSection("Variations",
                        "• Beginner: Assisted version\n• Advanced: Weighted version"),
                    _buildSection("Safety Notes",
                        "Warm up properly, avoid overloading, stop if you feel pain."),
                    _buildSection("Calories Burn Estimate",
                        "Approx. 4–6 calories per minute depending on intensity."),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // 💪 Muscle Group Highlight
              Text(
                "Muscle Group: $muscleGroup",
                style: const TextStyle(
                  color: Color(0xFFCCFF00), // ✅ Neon lime accent
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Color(0xFFCCFF00), // ✅ Neon lime glow
                      blurRadius: 12,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // ▶️ Play Tutorial Button
              if (videoUrl != null && videoUrl!.isNotEmpty)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCCFF00), // ✅ Neon lime accent
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 10,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoScreen(videoUrl: videoUrl!),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_circle_fill,
                      color: Colors.black, size: 26), // contrast on lime
                  label: const Text(
                    "Play Tutorial",
                    style: TextStyle(
                      color: Colors.black, // contrast on lime
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for sections
  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              color: Color(0xFFCCFF00), // ✅ Neon lime accent
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
