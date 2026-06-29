import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../repo/user_repo_impl.dart';

class EditProfileViewModel extends ChangeNotifier {
  final UserRepoImpl _userRepo = UserRepoImpl();
  
  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  EditProfileViewModel() {
    fetchUserData();
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

  Future<bool> updateProfile({
    required String name,
    required String email,
    required int age,
    required String height,
    required String weight,
    required String fitnessGoal,
  }) async {
    if (_user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = _user!.copyWith(
        name: name,
        email: email,
        age: age,
        height: height,
        weight: weight,
        fitnessGoal: fitnessGoal,
      );

      await _userRepo.editProfile(updatedUser);
      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
