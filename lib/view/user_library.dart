import 'package:flutter/material.dart';
import '../repo/library_repo_impl.dart';
import '../viewmodel/library_view_model.dart';
import 'exerciselistscreen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late final LibraryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LibraryViewModel(repository: LibraryRepoImpl());
    _viewModel.addListener(_onViewModelStateChange);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelStateChange);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelStateChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00))),
      );
    }

    final state = _viewModel.state;

    return Stack(
      children: [
        // Background Stack Profile
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
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 22),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            color: const Color(0xFFCCFF00),
            backgroundColor: const Color(0xFF161616),
            onRefresh: _viewModel.refreshLibraryState,
            child: Column(
              children: [
                // Muscle Target Grid Area
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
                    itemCount: state.muscleGroups.length,
                    itemBuilder: (context, index) {
                      final group = state.muscleGroups[index];
                      final imagePath = _viewModel.muscleGroupImages[group] ?? "assets/images/default.png";

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExerciseListScreen(
                                muscleGroup: group,
                                exercises: state.dynamicExerciseData[group]!,
                              ),
                            ),
                          ).then((_) => _viewModel.refreshLibraryState());
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
                                child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
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
                                        shadows: [Shadow(color: Colors.black, blurRadius: 6, offset: Offset(2, 2))],
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

                // Training Splits List Area (Conditionally visible based on Admin Flag)
                if (state.enableTrainingSplitsFlag)
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: _viewModel.trainingSplits.keys.map((splitName) {
                        return Card(
                          color: const Color(0xFF1E1E1E),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              splitName,
                              style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: const Icon(Icons.chevron_right, color: Colors.white),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SplitScreen(
                                    splitName: splitName,
                                    splitData: _viewModel.trainingSplits[splitName]!,
                                    onRefreshNeeded: _viewModel.refreshLibraryState,
                                  ),
                                ),
                              ).then((_) => _viewModel.refreshLibraryState());
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "TRAINING SPLITS DISABLED BY SYSTEM ADMIN",
                      style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                      textAlign:  TextAlign.center,
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
  final VoidCallback onRefreshNeeded;

  const SplitScreen({
    super.key,
    required this.splitName,
    required this.splitData,
    required this.onRefreshNeeded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0707),
        title: Text(splitName, style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold)),
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
              title: Text(dayName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              children: exercises.map((exercise) {
                return ListTile(
                  title: Text(exercise["name"] ?? "", style: const TextStyle(color: Colors.white)),
                  subtitle: Text("Sets: 3–4 • Reps: ${exercise["reps"] ?? "10"}", style: const TextStyle(color: Colors.white70)),
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
                    ).then((_) => onRefreshNeeded());
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