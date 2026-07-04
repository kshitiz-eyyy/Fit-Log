import 'package:flutter/material.dart';

import '../model/library_model.dart';
import '../repo/library_repo.dart';


class LibraryViewModel extends ChangeNotifier {
  final LibraryRepo _repository;

  LibraryViewModel({required LibraryRepo repository}) : _repository = repository {
    refreshLibraryState();
  }

  LibraryStateModel _state = LibraryStateModel.initial();
  LibraryStateModel get state => _state;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final Map<String, String> muscleGroupImages = {
    "Chest": "assets/images/chestdash.png",
    "Back": "assets/images/backdash.png",
    "Legs": "assets/images/legsdash.png",
    "Biceps": "assets/images/bicepsdash.png",
    "Triceps": "assets/images/tricepsdash.png",
    "Shoulders": "assets/images/shoulderdash.png",
    "Abs": "assets/images/absdash.png",
  };

  Future<void> refreshLibraryState() async {
    _isLoading = true;
    notifyListeners();

    _state = await _repository.getSynchronizedLibraryData();

    _isLoading = false;
    notifyListeners();
  }

  Map<String, Map<String, List<Map<String, String>>>> get trainingSplits {
    final data = _state.dynamicExerciseData;
    return {
      "Push/Pull/Legs": {
        "Push": (data["Chest"] ?? []) + (data["Shoulders"] ?? []) + (data["Triceps"] ?? []),
        "Pull": (data["Back"] ?? []) + (data["Biceps"] ?? []),
        "Legs": data["Legs"] ?? [],
      },
      "Bro Split": {
        "Chest Day": data["Chest"] ?? [],
        "Back Day": data["Back"] ?? [],
        "Shoulder Day": data["Shoulders"] ?? [],
        "Arm Day": (data["Biceps"] ?? []) + (data["Triceps"] ?? []),
        "Leg Day": data["Legs"] ?? [],
        "Abs Day": data["Abs"] ?? [],
      },
    };
  }
}