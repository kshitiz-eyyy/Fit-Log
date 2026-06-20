import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/exercise_view_model.dart';

class FavouriteExerciseScreen extends StatelessWidget {
  const FavouriteExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Favouties", style: TextStyle(color: Color(0xFFCCFF00))),
        centerTitle: true,
      ),
      body: Consumer<ExerciseViewModel>(
        builder: (context, vm, child) {
          // If the list is empty, show a centered message
          if (vm.favourites.isEmpty) {
            return const Center(
              child: Text(
                "No favourites yet",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          // If there is data, show the grid
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.7,
            ),
            itemCount: vm.favourites.length,
            itemBuilder: (context, index) {
              final ex = vm.favourites[index];
              return Card(
                color: const Color(0xFF0E0E0E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        ex.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.fitness_center, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ex.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          vm.toggleFavourite(ex, user.uid);
                        } else {
                          print("Error: No user logged in");
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}