import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_profile_model.dart';
import '../repo/user_profile_repo.dart';
import '../repo/user_profile_repo_impl.dart';

class UserProfileViewModel extends ChangeNotifier {
  final UserRepo _userRepo = UserRepoImpl();

  String athleteName = "Loading Athlete...";
  String athleteEmail = "athlete@fitlog.com";
  String athleteBio = "Consistency beats talent every single day.";
  String fitnessGoal = "Hypertrophy Conditioning";
  String membershipPlanText = "FitLog Regular Member";
  String? profileImagePath;

  bool biometricAuthEnabled = false;
  bool pushNotificationsEnabled = true;
  bool workoutRemindersEnabled = true;
  bool isDataSyncLoading = true;

  String getCurrentUserId() {
    User? liveFirebaseUser = FirebaseAuth.instance.currentUser;
    return liveFirebaseUser?.uid ?? "Eb3LsmAGcqNpd5pfwO28TpPyFWL2";
  }

  Future<void> fetchLiveProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      profileImagePath = prefs.getString('user_profile_img');
      biometricAuthEnabled = prefs.getBool('setting_biometric') ?? false;
      pushNotificationsEnabled = prefs.getBool('setting_push') ?? true;
      workoutRemindersEnabled = prefs.getBool('setting_reminders') ?? true;
      notifyListeners();

      String targetUid = getCurrentUserId();
      User? liveFirebaseUser = FirebaseAuth.instance.currentUser;
      athleteEmail = liveFirebaseUser?.email ?? "kritikatripathi0094@gmail.com";

      UserModel userModel = await _userRepo.getUserByID(targetUid);

      athleteName = userModel.name;
      athleteBio = userModel.bio;
      fitnessGoal = userModel.fitnessGoal;
      membershipPlanText = userModel.role == 'admin'
          ? "FitLog System Administrator"
          : "FitLog Pro Premium Access";

    } catch (e) {
      debugPrint("Profile data pipeline sync telemetry failure: $e");
    } finally {
      isDataSyncLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProfileChanges({
    required String name,
    required String bio,
    required String fitnessGoal,
  }) async {
    isDataSyncLoading = true;
    notifyListeners();

    try {
      String targetUid = getCurrentUserId();
      UserModel updatedUser = UserModel(
        id: targetUid,
        name: name,
        email: athleteEmail,
        bio: bio,
        fitnessGoal: fitnessGoal,
        role: membershipPlanText.contains('Administrator') ? 'admin' : 'user',
      );

      await _userRepo.editProfile(updatedUser);

      athleteName = name;
      athleteBio = bio;
      this.fitnessGoal = fitnessGoal;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_bio', bio);
      await prefs.setString('fitness_goal', fitnessGoal);
    } finally {
      isDataSyncLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePreferenceSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
      if (key == 'setting_biometric') biometricAuthEnabled = value;
      if (key == 'setting_push') pushNotificationsEnabled = value;
      if (key == 'setting_reminders') workoutRemindersEnabled = value;
    } else if (value is String) {
      await prefs.setString(key, value);
      if (key == 'user_profile_img') profileImagePath = value;
    }
    notifyListeners();
  }

  Future<void> addNewFitnessGoal(String goalTitle) async {
    if (goalTitle.trim().isEmpty) return;
    String targetUid = getCurrentUserId();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(targetUid)
        .collection('fitness_goals')
        .add({
      'goal_title': goalTitle.trim(),
      'status': 'active',
      'created_at': FieldValue.serverTimestamp(),
      'completed_at': null,
    });
  }

  Future<void> markGoalAsCompleted(String docId) async {
    String targetUid = getCurrentUserId();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(targetUid)
        .collection('fitness_goals')
        .doc(docId)
        .update({
      'status': 'completed',
      'completed_at': FieldValue.serverTimestamp(),
    });
  }
}