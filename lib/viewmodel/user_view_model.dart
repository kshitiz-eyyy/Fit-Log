import 'package:fitlog/model/user_model.dart';
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

  Future<Map<String, String>> login(String email, String password) async {
    _loading = true;
    _error = null;
    _role = null;
    notifyListeners();

    String detectedRole = 'user';

    try {
      final String userId = await _userRepo.login(email, password);
      print("DEBUG ViewModel - userId from auth: '$userId'");

      if (userId.isNotEmpty) {
        try {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

          print("DEBUG ViewModel - doc exists: ${userDoc.exists}");

          if (userDoc.exists && userDoc.data() != null) {
            final Object? rawData = userDoc.data();
            print("DEBUG ViewModel - raw Firestore data: $rawData");

            if (rawData is Map<String, dynamic>) {
              detectedRole = rawData['role']?.toString() ?? 'user';
              print("DEBUG ViewModel - detectedRole from Firestore: '$detectedRole'");
            } else {
              print("DEBUG ViewModel - rawData is NOT Map<String, dynamic>, it is: ${rawData.runtimeType}");
            }
          } else {
            print("DEBUG ViewModel - doc does NOT exist for userId: '$userId'");
          }
        } catch (databaseError) {
          print("DEBUG ViewModel - Firestore fetch ERROR: $databaseError");
          detectedRole = 'user';
        }
      } else {
        print("DEBUG ViewModel - userId is empty, skipping Firestore fetch");
      }

      _role = detectedRole;
      _loading = false;
      notifyListeners();

      print("DEBUG ViewModel - returning role: '$detectedRole'");

      return {
        "userId": userId,
        "role": detectedRole,
      };
    } catch (e) {
      print("DEBUG ViewModel - login ERROR: $e");
      _setError(e.toString().replaceAll("Exception: ", ""));
      _loading = false;
      notifyListeners();
      return {
        "userId": "",
        "role": "",
      };
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