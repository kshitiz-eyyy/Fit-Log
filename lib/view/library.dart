import 'package:flutter/material.dart';
import 'exercise_data.dart';
import 'exerciselistscreen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LibraryContent();
  }
}

class _LibraryContent extends StatelessWidget {
  _LibraryContent();

  final Map<String, List<Map<String, String>>> exerciseDataLocal = exerciseData;

  final Map<String, String> muscleGroupImages = const {
    "Chest": "assets/images/chestdash.png",
    "Back": "assets/images/backdash.png",
    "Legs": "assets/images/legsdash.png",
    "Biceps": "assets/images/bicepsdash.png",
    "Triceps": "assets/images/tricepsdash.png",
    "Shoulders": "assets/images/shoulderdash.png",
    "Abs": "assets/images/absdash.png",
  };

  @override
  Widget build(BuildContext context) {
    final muscleGroups = exerciseDataLocal.keys.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 10,
        automaticallyImplyLeading: false,
        title: const Text(
          "EXERCISE LIBRARY",
          style: TextStyle(
            color: Color(0xFFCCFF00),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final group = muscleGroups[index];
                final imagePath = muscleGroupImages[group] ?? "assets/images/default.png";

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExerciseListScreen(
                          muscleGroup: group,
                          exercises: exerciseDataLocal[group]!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCCFF00).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade900,
                              child: const Icon(Icons.fitness_center, color: Colors.white24, size: 50),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                                const Color(0xFFCCFF00).withOpacity(0.3),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.fitness_center,
                                  color: Color(0xFFCCFF00), size: 42),
                              const SizedBox(height: 10),
                              Text(
                                group.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 6,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "TRAINING SPLITS",
                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSplitTile(context, "Push/Pull/Legs"),
                _buildSplitTile(context, "Bro Split"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitTile(BuildContext context, String splitName) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: ListTile(
        title: Text(splitName,
            style: const TextStyle(
                color: Color(0xFFCCFF00),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
        onTap: () {
          // Training splits definition
          final Map<String, Map<String, List<Map<String, String>>>> trainingSplits = {
            "Push/Pull/Legs": {
              "Push": exerciseData["Chest"]! + exerciseData["Shoulders"]! + exerciseData["Triceps"]!,
              "Pull": exerciseData["Back"]! + exerciseData["Biceps"]!,
              "Legs": exerciseData["Legs"]!,
            },
            "Bro Split": {
              "Chest Day": exerciseData["Chest"]!,
              "Back Day": exerciseData["Back"]!,
              "Shoulder Day": exerciseData["Shoulders"]!,
              "Arm Day": exerciseData["Biceps"]! + exerciseData["Triceps"]!,
              "Leg Day": exerciseData["Legs"]!,
              "Abs Day": exerciseData["Abs"]!,
            },
          };

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SplitScreen(
                splitName: splitName,
                splitData: trainingSplits[splitName]!,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SplitScreen extends StatelessWidget {
  final String splitName;
  final Map<String, List<Map<String, String>>> splitData;

  const SplitScreen({super.key, required this.splitName, required this.splitData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text(splitName,
            style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: splitData.keys.map((dayName) {
          final exercises = splitData[dayName]!;
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ExpansionTile(
              title: Text(dayName,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              children: exercises.map((exercise) {
                return ListTile(
                  title: Text(exercise["name"] ?? "",
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text("Sets: 3–4 • Reps: ${exercise["reps"] ?? "10"}",
                      style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.fitness_center, color: Color(0xFFCCFF00)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExerciseListScreen(
                          muscleGroup: dayName,
                          exercises: exercises,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
