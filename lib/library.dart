import 'package:flutter/material.dart';
import 'exercise_data.dart';
import 'exerciselistscreen.dart';
import 'activity_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    Center(child: Text("HOME", style: TextStyle(color: Colors.white))),
    Center(child: Text("FEATURES", style: TextStyle(color: Colors.white))),
    _LibraryContent(),
    ActivityScreen(),
    Center(child: Text("PROFILE", style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: const Color(0xFFCCFF00),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.featured_video_outlined), label: "Features"),
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
      ),
    );
  }
}

class _LibraryContent extends StatelessWidget {
  final muscleGroups = exerciseData.keys.toList();

  // Map muscle groups to their images
  final Map<String, String> muscleGroupImages = {
    "Chest": "assets/images/chestdash.png",
    "Back": "assets/images/backdash.png",
    "Legs": "assets/images/legsdash.png",
    "Biceps": "assets/images/bicepsdash.png",
    "Triceps": "assets/images/tricepsdash.png",
    "Shoulders": "assets/images/shoulderdash.png",
    "Abs": "assets/images/absdash.png",
    // Add more as needed
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with dark overlay
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gym.png"),
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
              // Hero banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF121212),
                      const Color(0xFF1E1E1E),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("WELCOME BACK, COMMANDER",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text("PUSH YOUR LIMITS TODAY",
                        style: TextStyle(color: Color(0xFFCCFF00), fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Neon Start Workout Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF121212),
                  foregroundColor: const Color(0xFFCCFF00),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  side: const BorderSide(color: Color(0xFFCCFF00), width: 2),
                  elevation: 20,
                  shadowColor: const Color(0xFFCCFF00),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Starting workout...")),
                  );
                },
                icon: const Icon(Icons.play_arrow, size: 28),
                label: const Text("START WORKOUT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),

              const SizedBox(height: 20),

              // Grid of muscle groups with image cards
              Expanded(
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
                            // Background image per muscle group
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),

                            // Gradient overlay
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

                            // Content overlay
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.fitness_center,
                                      color: const Color(0xFFCCFF00), size: 42),
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
            ],
          ),
        ),
      ],
    );
  }
}
