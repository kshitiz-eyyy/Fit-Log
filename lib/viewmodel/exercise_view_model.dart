import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/exercise_model.dart';

class ExerciseViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Exercise> _favourites = [];
  List<Exercise> get favourites => _favourites;

  ExerciseViewModel() {
    _listenToFavourites();
  }

  void _listenToFavourites() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _db.collection('users').doc(user.uid).collection('favourites')
        .snapshots().listen((snapshot) {
      _favourites = snapshot.docs.map((doc) => Exercise.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    });
  }

  Future<void> toggleFavourite(Exercise ex) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = _db.collection('users').doc(user.uid).collection('favourites').doc(ex.name);

    if (_favourites.any((f) => f.name == ex.name)) {
      await ref.delete();
    } else {
      await ref.set({
        'name': ex.name, 'image': ex.image, 'video': ex.video,
        'instructions': ex.instructions, 'muscle': ex.muscle,
        'level': ex.level, 'equipment': ex.equipment
      });
    }
  }
}