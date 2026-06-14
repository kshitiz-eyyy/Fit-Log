import 'dart:async';
import 'package:flutter/material.dart';
import '../model/dietitian_model.dart';
import '../repo/dietitian_repo.dart';

class DietitianViewModel extends ChangeNotifier {
  final DietitianRepo _dietitianRepo = DietitianRepo();

  List<DietitianModel> _dietitian = [];
  List<DietitianModel> get dietitian=> _dietitian;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  StreamSubscription? _dietitianSubscription;

  DietitianViewModel() {
    listenToDietitian();
  }

  void listenToDietitian() {
    _dietitianSubscription?.cancel();
    _dietitianSubscription = _dietitianRepo.getDietitianStream().listen((dietitianList) {
      _dietitian = dietitianList;
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _dietitianSubscription?.cancel();
    super.dispose();
  }
}