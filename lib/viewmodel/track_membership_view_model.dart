import 'package:flutter/material.dart';
import '../model/membership_model.dart';
import '../repo/membership_repo.dart';
import '../repo/membership_repo_impl.dart';

class TrackMembershipViewModel extends ChangeNotifier {
  final MembershipRepo _repo;

  MembershipModel? _membership;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;

  TrackMembershipViewModel({MembershipRepo? repo})
      : _repo = repo ?? MembershipRepoImpl() {
    loadMembership();
  }

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;

  int get daysRemaining => _membership?.daysRemaining ?? 0;
  int get totalDays => _membership?.totalDays ?? 30;
  double get progress => _membership?.progress ?? 0;
  DateTime get cycleResetDate =>
      _membership?.cycleResetDate ?? DateTime.now();
  String get planName => _membership?.planName ?? 'Standard Track';
  String get planSubtitle =>
      _membership?.planSubtitle ?? 'Full Access Tracker';
  String get tier => _membership?.tier ?? 'PREMIUM PRO';
  bool get isActive => _membership?.isActive ?? false;

  Future<void> loadMembership() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _membership = await _repo.fetchMembership();
    } catch (e) {
      _errorMessage = e.toString();
      _membership = MembershipModel.defaults();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> refreshCycle() async {
    _isSaving = true;
    notifyListeners();

    try {
      await _repo.refreshCycle();
      _membership = await _repo.fetchMembership();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> resetProgressData() async {
    _isSaving = true;
    notifyListeners();

    try {
      await _repo.resetProgress();
      _membership = await _repo.fetchMembership();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
