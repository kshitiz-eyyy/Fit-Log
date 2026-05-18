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
        backgroundColor: Colors.black,
        selectedItemColor: Colors.lightGreenAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.featured_video_sharp), label: "Features"),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with dark overlay
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/gym.png"), // add your background image
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.8),
            elevation: 10,
            title: const Text(
              "Library",
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Hero banner with motivational text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.8), Colors.green.shade900.withOpacity(0.7)],
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
                        style: TextStyle(color: Colors.lightGreenAccent, fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Neon Start Workout Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.lightGreenAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  side: BorderSide(color: Colors.lightGreenAccent, width: 2),
                  elevation: 20,
                  shadowColor: Colors.greenAccent,
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

              // Grid of muscle groups with attractive cards
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: muscleGroups.length,
                  itemBuilder: (context, index) {
                    final group = muscleGroups[index];
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
                          image: DecorationImage(
                            image: AssetImage("assets/images/${group.toLowerCase()}.jpg"), // add per-group images
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 12, offset: Offset(0, 6)),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sports_gymnastics, color: Colors.lightGreenAccent, size: 40),
                              const SizedBox(height: 10),
                              Text(
                                group.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
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
