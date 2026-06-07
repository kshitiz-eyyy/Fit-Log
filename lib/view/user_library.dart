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
  Map<String, List<Map<String, String>>> dynamicExerciseData = {};
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

  @override
  void initState() {
    super.initState();
    _syncAdminAndStaticDatabase();
  }

  Future<void> _syncAdminAndStaticDatabase() async {
    final prefs = await SharedPreferences.getInstance();


    Map<String, List<Map<String, String>>> synchronizedData = {};
    exerciseData.forEach((key, value) {
      synchronizedData[key] = List<Map<String, String>>.from(value);
    });


    List<String> customInjections = prefs.getStringList('admin_custom_exercises') ?? [];


    for (String item in customInjections) {
      var parts = item.split('|');
      if (parts.length == 2) {
        String exerciseName = parts[0];
        String targetCategory = parts[1];


        if (!synchronizedData.containsKey(targetCategory)) {
          synchronizedData[targetCategory] = [];
        }

        synchronizedData[targetCategory]!.add({
          "name": exerciseName,
          "reps": "10-12",
        });
      }
    }

    setState(() {
      dynamicExerciseData = synchronizedData;
      muscleGroups = dynamicExerciseData.keys.toList();
    });
  }

  Map<String, Map<String, List<Map<String, String>>>> get trainingSplits {
    return {
      "Push/Pull/Legs": {
        "Push": (dynamicExerciseData["Chest"] ?? []) + (dynamicExerciseData["Shoulders"] ?? []) + (dynamicExerciseData["Triceps"] ?? []),
        "Pull": (dynamicExerciseData["Back"] ?? []) + (dynamicExerciseData["Biceps"] ?? []),
        "Legs": dynamicExerciseData["Legs"] ?? [],
      },
      "Bro Split": {
        "Chest Day": dynamicExerciseData["Chest"] ?? [],
        "Back Day": dynamicExerciseData["Back"] ?? [],
        "Shoulder Day": dynamicExerciseData["Shoulders"] ?? [],
        "Arm Day": (dynamicExerciseData["Biceps"] ?? []) + (dynamicExerciseData["Triceps"] ?? []),
        "Leg Day": dynamicExerciseData["Legs"] ?? [],
        "Abs Day": dynamicExerciseData["Abs"] ?? [],
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    if (muscleGroups.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00))),
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
            backgroundColor: const Color(0xFF0E0707),
            elevation: 10,
            title: const Text(
              "Library",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: const Color(0xFFCCFF00),
            backgroundColor: const Color(0xFF161616),
            onRefresh: _syncAdminAndStaticDatabase,
            child: Column(
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
                                exercises: dynamicExerciseData[group]!,
                              ),
                            ),
                          ).then((_) => _syncAdminAndStaticDatabase());
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

                Expanded(
                  flex: 1,
                  child: ListView(
                    children: trainingSplits.keys.map((splitName) {
                      return Card(
                        color: const Color(0xFF1E1E1E),
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: ListTile(
                          title: Text(splitName,
                              style: const TextStyle(
                                  color: Color(0xFFCCFF00),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
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
                            ).then((_) => _syncAdminAndStaticDatabase());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
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
        backgroundColor: const Color(0xFF0E0707),
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