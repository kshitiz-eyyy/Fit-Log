import 'package:flutter/material.dart';
import '../repo/terms_repo_impl.dart';

class TermsViewModel extends ChangeNotifier {
  final TermsRepo _repo = TermsRepo();

  String _termsText = "";
  bool _isLoading = true;

  String get termsText => _termsText;
  bool get isLoading => _isLoading;

  TermsViewModel() {
    loadTerms();
  }

  Future<void> loadTerms() async {
    _isLoading = true;
    notifyListeners();

    _termsText = await _repo.fetchTerms();

    _isLoading = false;
    notifyListeners();
  }
}