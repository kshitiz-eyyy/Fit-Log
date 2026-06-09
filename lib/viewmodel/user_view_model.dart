import 'package:fitlog/model/user_model.dart'; // <-- UPDATE THIS PATH TO MATCH YOUR ACTUAL MODEL FILE
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repo/user_repo_impl.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepoImpl _userRepo = UserRepoImpl();

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  String? _role;
  String? get role => _role;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
  }

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
      return "";
    }
  }

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

  Future<String> login(String email, String password) async {
    _setLoading(true);
    _setError(null);
    _role = null;
    try {
      final String userId = await _userRepo.login(email, password);

      if (userId.isNotEmpty) {
        try {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

          if (userDoc.exists && userDoc.data() != null) {
            final Object? rawData = userDoc.data();
            if (rawData is Map<String, dynamic>) {
              _role = rawData['role']?.toString() ?? 'user';
            } else {
              _role = 'user';
            }
          } else {
            _role = 'user';
          }
        } catch (databaseError) {
          _role = 'user';
        }
      }

      _setLoading(false);
      return userId;
    } catch (e) {
      _setError(e.toString().replaceAll("Exception: ", ""));
      _setLoading(false);
      return "";
    }
  }

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

  Future<void> logout() async {
    await _userRepo.logout();
    _role = null;
    notifyListeners();
  }
}