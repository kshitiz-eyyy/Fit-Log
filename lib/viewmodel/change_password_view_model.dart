import 'package:flutter/material.dart';
import '../repo/password_repo.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final PasswordRepo _repository;

  ChangePasswordViewModel({required PasswordRepo repository}) : _repository = repository;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;
  bool isLoading = false;

  void toggleObscureCurrent() {
    obscureCurrent = !obscureCurrent;
    notifyListeners();
  }

  void toggleObscureNew() {
    obscureNew = !obscureNew;
    notifyListeners();
  }

  void toggleObscureConfirm() {
    obscureConfirm = !obscureConfirm;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  bool get hasMin10Chars => newPasswordController.text.length >= 10;
  bool get hasSpecialSymbol =>
      newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get hasNumericValue =>
      newPasswordController.text.contains(RegExp(r'[0-9]'));
  bool get hasUppercase =>
      newPasswordController.text.contains(RegExp(r'[A-Z]'));

  bool get passwordsMatch => newPasswordController.text == confirmPasswordController.text;
  bool get showMismatchError => confirmPasswordController.text.isNotEmpty && !passwordsMatch;

  double get strengthProgress {
    int count = 0;
    if (hasMin10Chars) count++;
    if (hasSpecialSymbol) count++;
    if (hasNumericValue) count++;
    if (hasUppercase) count++;
    return count / 4;
  }

  String get strengthText {
    double progress = strengthProgress;
    if (progress >= 1.0) return 'ELITE';
    if (progress >= 0.75) return 'STRONG';
    if (progress >= 0.5) return 'FAIR';
    if (progress >= 0.25) return 'WEAK';
    return 'NONE';
  }

  Future<void> handleAuthorizeUpdate({
    required VoidCallback onSuccess,
    required Function(String) onError,
    required VoidCallback onMismatch,
  }) async {
    if (!passwordsMatch) {
      onMismatch();
      return;
    }

    if (strengthProgress < 1.0) {
      onError('Please meet all security requirements.');
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _repository.updatePassword(
        currentPasswordController.text.trim(),
        newPasswordController.text.trim(),
      );
      // Clear controllers on success
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      isLoading = false;
      notifyListeners();
      onSuccess();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      onError(e.toString());
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
