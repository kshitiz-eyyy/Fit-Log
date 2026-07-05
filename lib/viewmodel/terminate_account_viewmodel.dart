import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../repo/user_repo_impl.dart';

class TerminateAccountViewModel extends ChangeNotifier {
  final UserRepoImpl _userRepo = UserRepoImpl();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _understandRisks = false;
  bool get understandRisks => _understandRisks;

  String? _error;
  String? get error => _error;

  TerminateAccountViewModel() {
    fetchUserData();
  }

  void toggleUnderstandRisks() {
    _understandRisks = !_understandRisks;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        _user = await _userRepo.getUserByID(userId);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> terminateAccount() async {
    if (!_understandRisks) {
      _error = "You must understand the risks to proceed.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _userRepo.terminateAccount();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
