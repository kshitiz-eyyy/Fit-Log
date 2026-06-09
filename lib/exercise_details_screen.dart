import 'package:flutter/material.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Premium Cyber Dark Palette definitions
    const Color bgColor = Color(0xFF0A0A0A);
    const Color cardColor = Color(0xFF161618);
    const Color neonLime = Color(0xFFCCFF00);
    const Color subTextColor = Color(0xFFA0A0A5);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "EXERCISE DETAILS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge & Header Title
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ), // Fixed: 'py' changed to 'vertical'
              decoration: BoxDecoration(
                color: neonLime.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: neonLime.withOpacity(0.3), width: 1),
              ),
              child: const Text(
                "CHEST TARGET",
                style: TextStyle(
                  color: neonLime,
                  fontSize: 11,
                  fontWeight:
                  FontWeight.w900, // Fixed: Changed from .black to .w900
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Bench Press",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight:
                FontWeight.w800, // Fixed: Changed from .extrabold to .w800
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 20),

            // Image Container Block with Crash Fallback Setup
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/Benchpress.png",
                  fit: BoxFit.cover,
                  // Catches missing files cleanly and shows a cyber placeholder
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: cardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center_rounded,
                            size: 50,
                            color: neonLime.withOpacity(0.8),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Demonstration Diagram Asset Missing",
                            style: TextStyle(
                              color: subTextColor.withOpacity(0.6),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Instructions Header Title Area
            Row(
              children: [
                Icon(
                  Icons.format_list_bulleted_rounded,
                  color: neonLime,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  "EXECUTION PROTOCOL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 24, thickness: 1),

            // Instruction Checklist Items Block
            const InstructionItem(
              "Keep your shoulder blades retracted throughout the lift for better joint stability.",
            ),
            const InstructionItem(
              "Do not flare your elbows excessively—aim for ~45°–60° from the body.",
            ),
            const InstructionItem(
              "Maintain a tight glute and leg drive to anchor your base.",
            ),
            const InstructionItem(
              "Keep wrist alignment neutral to avoid strain.",
            ),
            const InstructionItem(
              "Lower the bar under control; don’t bounce it off the chest.",
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  final String text;
  const InstructionItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    const Color neonLime = Color(0xFFCCFF00);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF161618),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.02)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Icon(Icons.bolt, size: 16, color: neonLime),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFFE0E0E6),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}