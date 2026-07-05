import 'package:flutter/material.dart';
import '../repo/rate_repo.dart';
import '../repo/rate_repo_impl.dart';

class RateViewModel extends ChangeNotifier {
  final RateRepo _repo;

  int _rating = 0;
  bool _isSubmitting = false;
  String? _errorMessage;
  final TextEditingController feedbackController = TextEditingController();

  RateViewModel({RateRepo? repo}) : _repo = repo ?? RateRepoImpl();

  int get rating => _rating;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  void setRating(int newRating) {
    if (_rating == newRating) return;
    _rating = newRating;
    notifyListeners();
  }

  Future<bool> submitReview() async {
    if (_rating == 0) return false;

    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repo.submitReview(
        rating: _rating,
        feedback: feedbackController.text.trim(),
      );

      _isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
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
