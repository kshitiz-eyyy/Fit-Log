import 'package:flutter/material.dart';

import '../model/admin_config_model.dart';
import '../repo/admin_repo.dart';

class AdminViewModel extends ChangeNotifier {
  final AdminRepo _repository;

  AdminViewModel({required AdminRepo repository}) : _repository = repository {
    _init();
  }

  final globalChallengeCtrl = TextEditingController();
  final systemNoticeCtrl = TextEditingController();
  final customExerciseNameCtrl = TextEditingController();
  final exerciseImageCtrl = TextEditingController();
  final exerciseVideoCtrl = TextEditingController();
  final exerciseInstructionsCtrl = TextEditingController();

  String selectedMuscleCategory = "Chest";
  final List<String> availableCategories = ["Chest", "Back", "Legs", "Biceps", "Triceps", "Shoulders", "Abs"];

  AdminConfigModel _config = AdminConfigModel.initial();
  AdminConfigModel get config => _config;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> _init() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    _config = await _repository.loadAdminSettings();

    globalChallengeCtrl.text = _config.globalChallengeName;
    systemNoticeCtrl.text = _config.systemNoticeText;

    _isLoading = false;
    notifyListeners();
  }

  void toggleShowNotice(bool val) {
    _config = _config.copyWith(showSystemNoticeAlert: val);
    notifyListeners();
  }

  void toggleVideoTutorials(bool val) {
    _config = _config.copyWith(enableVideoTutorials: val);
    notifyListeners();
  }

  void toggleTrainingSplits(bool val) {
    _config = _config.copyWith(enableTrainingSplits: val);
    notifyListeners();
  }

  void toggleForcePremium(bool val) {
    _config = _config.copyWith(forcePremiumToAll: val);
    notifyListeners();
  }

  void updateMuscleCategory(String category) {
    selectedMuscleCategory = category;
    notifyListeners();
  }

  Future<bool> addNewExerciseInjection() async {
    final name = customExerciseNameCtrl.text.trim();
    final img = exerciseImageCtrl.text.trim();
    final vid = exerciseVideoCtrl.text.trim();
    final instructions = exerciseInstructionsCtrl.text.trim();

    if (name.isEmpty) return false;

    final formattedPayload = "$name|$selectedMuscleCategory|$img|$vid|$instructions";

    List<String> updatedList = List.from(_config.injectedExercisesList)..add(formattedPayload);
    _config = _config.copyWith(injectedExercisesList: updatedList);

    customExerciseNameCtrl.clear();
    exerciseImageCtrl.clear();
    exerciseVideoCtrl.clear();
    exerciseInstructionsCtrl.clear();

    notifyListeners();
    await _repository.saveCustomExercises(updatedList);
    return true;
  }

  Future<void> clearAllCustomExercises() async {
    _config = _config.copyWith(injectedExercisesList: []);
    notifyListeners();
    await _repository.clearCustomExercises();
  }

  Future<void> commitSystemConfiguration() async {
    _config = _config.copyWith(
      globalChallengeName: globalChallengeCtrl.text.trim(),
      systemNoticeText: systemNoticeCtrl.text.trim(),
    );

    await _repository.saveAdminSettings(_config);
  }

  @override
  void dispose() {
    globalChallengeCtrl.dispose();
    systemNoticeCtrl.dispose();
    customExerciseNameCtrl.dispose();
    exerciseImageCtrl.dispose();
    exerciseVideoCtrl.dispose();
    exerciseInstructionsCtrl.dispose();
    super.dispose();
  }
}