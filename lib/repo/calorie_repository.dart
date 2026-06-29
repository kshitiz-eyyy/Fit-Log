import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../model/meal_model.dart';

abstract class ICalorieRepository {
  Future<List<Meal>> getMeals();
  Future<void> saveMeals(List<Meal> meals);
}

class CalorieRepositoryImpl implements ICalorieRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser?.uid ?? '';
  String get _today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Future<List<Meal>> getMeals() async {
    if (_userId.isEmpty) return [];

    try {
      final doc = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('calorie_logs')
          .doc(_today)
          .get();

      if (doc.exists && doc.data() != null) {
        final List<dynamic> mealsData = doc.data()!['meals'] ?? [];
        return mealsData.map((m) => Meal.fromMap(m as Map<String, dynamic>)).toList();
      } else {
        // Return default empty meals if day doesn't exist
        return [
          Meal(name: 'Breakfast', calories: 0),
          Meal(name: 'Lunch', calories: 0),
          Meal(name: 'Dinner', calories: 0),
          Meal(name: 'Snack', calories: 0),
        ];
      }
    } catch (e) {
      print('Error fetching meals: $e');
      return [];
    }
  }

  @override
  Future<void> saveMeals(List<Meal> meals) async {
    if (_userId.isEmpty) return;

    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('calorie_logs')
          .doc(_today)
          .set({
        'meals': meals.map((m) => m.toMap()).toList(),
        'total_calories': meals.fold(0, (sum, m) => sum + m.calories),
        'last_updated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving meals: $e');
    }
  }
}
