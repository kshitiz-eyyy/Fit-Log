import 'package:flutter/material.dart';

class RateViewModel extends ChangeNotifier {
  int _rating = 0;
  bool _isSubmitting = false;
  final TextEditingController feedbackController = TextEditingController();

  // Getters
  int get rating => _rating;
  bool get isSubmitting => _isSubmitting;

  // Update Rating Selection
  void setRating(int newRating) {
    if (_rating == newRating) return;
    _rating = newRating;
    notifyListeners();
  }

  // Handle Review Submission Logic
  Future<bool> submitReview() async {
    if (_rating == 0) return false;

    _isSubmitting = true;
    notifyListeners();

    try {
      // Simulate network request/database write latency
      await Future.delayed(const Duration(milliseconds: 800));

      // TODO: Connect this to your Firestore or remote backend repository if needed
      // String feedbackText = feedbackController.text.trim();

      _isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}