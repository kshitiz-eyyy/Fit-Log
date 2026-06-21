import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fitlog/repo/user_repo_impl.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepoImpl userRepo;
  UserViewModel({required this.userRepo});

  // ── State ──────────────────────────────────────────────────────
  bool   isLoading        = false;
  bool   isSaving         = false;
  bool   isUploadingAvatar = false;
  String? errorMessage;

  String adminName     = '';
  String adminEmail    = '';
  String adminPhone    = '';
  String adminLocation = '';
  String avatarUrl     = '';
  int    totalMembers  = 0;
  int    activeTrainers = 0;

  // ── Fetch profile from Firebase ────────────────────────────────
  Future<void> fetchAdminProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await userRepo.getAdminProfile(); // returns Map<String,dynamic>
      adminName      = data['name']     ?? '';
      adminEmail     = data['email']    ?? '';
      adminPhone     = data['phone']    ?? '';
      adminLocation  = data['location'] ?? '';
      avatarUrl      = data['avatarUrl'] ?? '';
      totalMembers   = data['totalMembers']   ?? 0;
      activeTrainers = data['activeTrainers'] ?? 0;
    } catch (e) {
      errorMessage = "Failed to load profile. Check your connection.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ── Save updated profile to Firebase ──────────────────────────
  Future<bool> updateAdminProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      await userRepo.updateAdminProfile({
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
      });
      adminName = name;
      adminEmail = email;
      adminPhone = phone;
      adminLocation = location;
      return true;
    } catch (e) {
      errorMessage = "Save failed: ${e.toString()}";
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // ── Upload avatar to Firebase Storage ─────────────────────────
  Future<void> uploadAvatar(File image) async {
    isUploadingAvatar = true;
    notifyListeners();

    try {
      final url = await userRepo.uploadAvatarImage(image);
      avatarUrl = url;
    } catch (e) {
      errorMessage = "Avatar upload failed.";
    } finally {
      isUploadingAvatar = false;
      notifyListeners();
    }
  }
}














