import 'dart:async';
import 'package:flutter/material.dart';
import '../model/trainer_model.dart';
import '../repo/trainer_repo.dart';

class TrainerViewModel extends ChangeNotifier {
  final TrainerRepo _trainerRepo = TrainerRepo();

  List<TrainerModel> _trainers = [];
  List<TrainerModel> get trainers => _trainers;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  StreamSubscription? _trainerSubscription;

  TrainerViewModel() {
    listenToTrainers();
  }


  void listenToTrainers() {
    _trainerSubscription?.cancel();
    _trainerSubscription = _trainerRepo.getTrainersStream().listen((trainerList) {
      _trainers = trainerList;
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _trainerSubscription?.cancel();
    super.dispose();
  }
}