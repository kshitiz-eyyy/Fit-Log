import 'package:flutter/material.dart';
import 'user_library.dart';
import 'favourite_manager.dart'; // ✅ global favourites list

class FavouriteExerciseScreen extends StatelessWidget {
  const FavouriteExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color neonLime = Color(0xFFCCFF00); // ✅ Unified neon accent

    return Scaffold(
      backgroundColor: Colors.black, // ✅ Matches app background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E0E), // ✅ Deep dark header surface
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "MY FAVOURITE EXERCISES",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: neonLime, // ✅ Bold neon look
            letterSpacing: 2,
          ),
        ),
      ),
      body: favouriteExercises.isEmpty
          ? const Center(
        child: Text(
          "No favourites yet",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      )
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF051000)], // ✅ Sleek, dark green undertone
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.78, // Slightly extended to prevent text overflow
                ),
                itemCount: favouriteExercises.length,
                itemBuilder: (context, index) {
                  final exercise = favouriteExercises[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E0E0E), // ✅ Deep dark grey/black card surface
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: neonLime.withValues(alpha: 0.25), // ✅ Subtle neon borders
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neonLime.withValues(alpha: 0.08), // ✅ Classy ambient neon glow
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🖼 Exercise Image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          child: Image.asset(
                            exercise["image"]!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        exercise["name"]!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        favouriteExercises.removeAt(index);
                                        (context as Element).markNeedsBuild();
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent, // ✅ Changed back to Red
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${exercise["muscle"] ?? "Muscle"} • ${exercise["equipment"] ?? "Bodyweight"}",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white60,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "Level: ${exercise["level"] ?? "All"}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: neonLime,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ▶️ Discover Exercises Button Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonLime, // ✅ Bright neon button
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  elevation: 6,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LibraryScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search, size: 18),
                label: const Text(
                  "DISCOVER EXERCISES",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // 📊 Bottom Metric Panel
            Container(
              color: const Color(0xFF0E0E0E), // ✅ Matte black stats deck
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem("Saved", "${favouriteExercises.length}", neonLime),
                  _buildStatItem("Completion", "92%", neonLime),
                  _buildStatItem("Recorded", "24 reps", neonLime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to keep the bottom deck tidy and scannable
  Widget _buildStatItem(String label, String value, Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}