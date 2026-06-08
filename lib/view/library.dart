import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_data.dart';
import 'exerciselistscreen.dart';
import 'user_activity_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const Center(child: Text("HOME", style: TextStyle(color: Colors.white))),
    const Center(child: Text("FEATURES", style: TextStyle(color: Colors.white))),
    const _LibraryContent(),
    const ActivityScreen(),
    const Center(child: Text("PROFILE", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
    );
  }
}

class _LibraryContent extends StatefulWidget {
  const _LibraryContent();

  @override
  State<_LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<_LibraryContent> {
  List<String> muscleGroups = [];

  final Map<String, String> muscleGroupImages = {
    "Chest": "assets/images/chestdash.png",
    "Back": "assets/images/backdash.png",
    "Legs": "assets/images/legsdash.png",
    "Biceps": "assets/images/bicepsdash.png",
    "Triceps": "assets/images/tricepsdash.png",
    "Shoulders": "assets/images/shoulderdash.png",
    "Abs": "assets/images/absdash.png",
  };

  Map<String, Map<String, List<Map<String, String>>>> trainingSplits = {};

  @override
  void initState() {
    super.initState();
    _syncAdminAndStaticDatabase();
  }

  Future<void> _syncAdminAndStaticDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> adminInjections = prefs.getStringList('admin_custom_exercises') ?? [];

    for (String payload in adminInjections) {
      // Split using our multi-token delimiter standard
      List<String> parts = payload.split('|');

      if (parts.length >= 2) {
        String name = parts[0];
        String category = parts[1];

        // Match positions against fields provided by our upgraded Admin Panel
        String image = (parts.length > 2 && parts[2].isNotEmpty) ? parts[2] : "";
        String video = (parts.length > 3 && parts[3].isNotEmpty) ? parts[3] : "";
        String instructions = (parts.length > 4 && parts[4].isNotEmpty) ? parts[4] : "Custom routine added by admin.";

        if (exerciseData.containsKey(category)) {
          // Check for duplicate names inside memory arrays
          bool exists = exerciseData[category]!.any((e) => e['name'] == name);

          if (!exists) {
            exerciseData[category]!.add({
              "name": name,
              "image": image,
              "video": video,
              "instructions": instructions,
            });
          }
        }
      }
    }

    // After updating map variables, reconstruct state collections
    setState(() {
      muscleGroups = exerciseData.keys.toList();

      trainingSplits = {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading spinner if SharedPreferences asynchronous reading hasn't finished loading keys
    if (muscleGroups.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFCCFF00)),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/gym.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color(0xFF121212).withOpacity(0.7),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xFF121212),
            elevation: 10,
            title: const Text(
              "Library",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Muscle Group Grid viewports
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
                              exercises: exerciseData[group]!,
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
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback layout block in case an invalid dynamic system asset string path is typed
                                  return Container(
                                    color: const Color(0xFF1E1E1E),
                                    child: const Center(
                                      child: Icon(Icons.fitness_center, color: Colors.grey, size: 40),
                                    ),
                                  );
                                },
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
                                  const Icon(Icons.fitness_center, color: Color(0xFFCCFF00), size: 42),
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

              // Splits Section layout modules at footing layout zones
              Expanded(
                flex: 1,
                child: ListView(
                  children: trainingSplits.keys.map((splitName) {
                    return Card(
                      color: const Color(0xFF1E1E1E),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          splitName,
                          style: const TextStyle(
                            color: Color(0xFFCCFF00),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.white),
                        onTap: () {
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
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
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
        title: Text(
          splitName,
          style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold),
        ),
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
              iconColor: const Color(0xFFCCFF00),
              collapsedIconColor: Colors.white,
              title: Text(
                dayName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              children: exercises.map((exercise) {
                return ListTile(
                  title: Text(
                    exercise["name"] ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Sets: 3–4 • Reps: ${exercise["reps"] ?? "10"}",
                    style: const TextStyle(color: Colors.white70),
                  ),
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