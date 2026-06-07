import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../repo/user_repo_impl.dart';

class UserViewModel extends ChangeNotifier {
  // Instantiate your repository implementation
  final UserRepoImpl _userRepo = UserRepoImpl();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
  }

  /// Registration logic used by your RegisterScreen
  Future<String> register(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      final String userId = await _userRepo.register(email, password);
      _setLoading(false);
      return userId;
    } catch (e) {
      _setError(e.toString().replaceAll("Exception: ", ""));
      _setLoading(false);
      return ""; // Returns empty string on failure as your UI checks for .isEmpty
    }
  }

  /// Adds user data to Firestore collection
  Future<bool> addUser(UserModel userModel) async {
    _setLoading(true);
    _setError(null);
    try {
      await _userRepo.addUser(userModel);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll("Exception: ", ""));
      _setLoading(false);
      return false;
    }
  }

  /// Login Logic for your Login Screen
  Future<String> login(String email, String password) async {
    _setLoading(true);
    _setError(null);
    try {
      final String userId = await _userRepo.login(email, password);
      _setLoading(false);
      return userId;
    } catch (e) {
      _setError(e.toString().replaceAll("Exception: ", ""));
      _setLoading(false);
      return "";
    }
  }

  /// Forgot Password Logic
  Future<bool> forgetPassword(String email) async {
    _setLoading(true);
    _setError(null);
    try {
      await _userRepo.forgetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString().replaceAll("Exception: ", ""));
      _setLoading(false);
      return false;
    }
  }

  /// Logout Logic
  Future<void> logout() async {
    await _userRepo.logout();
    notifyListeners();
  }
}