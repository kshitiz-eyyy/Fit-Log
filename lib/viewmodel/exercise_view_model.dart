import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/exercise_model.dart';

class ExerciseViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Exercise> _favourites = [];
  List<Exercise> get favourites => _favourites;

  ExerciseViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _listenToFavourites(user.uid);
      } else {
        _favourites = [];
        notifyListeners();
      }
    });
  }

  void _listenToFavourites(String uid) {
    _db.collection('users').doc(uid).collection('favourites')
        .snapshots().listen((snapshot) {
      _favourites = snapshot.docs.map((doc) => Exercise.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    });
  }

  Future<void> toggleFavourite(Exercise ex, String uid) async {
    if (uid.isEmpty) return;

    final ref = _db.collection('users').doc(uid).collection('favourites').doc(ex.name);

    final doc = await ref.get();
    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'name': ex.name,
        'image': ex.image,
        'video': ex.video,
        'instructions': ex.instructions,
        'muscle': ex.muscle,
        'level': ex.level,
        'equipment': ex.equipment,
      });
    }
    notifyListeners();
  }
}