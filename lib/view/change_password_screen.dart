import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/change_password_view_model.dart';
import '../repo/password_repo_impl.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(repository: PasswordRepoImpl()),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ChangePasswordViewModel>(context, listen: false);
      viewModel.newPasswordController.addListener(viewModel.updateState);
      viewModel.confirmPasswordController.addListener(viewModel.updateState);
    });
  }

  void _handleUpdate(ChangePasswordViewModel viewModel) {
    viewModel.handleAuthorizeUpdate(
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Updating password... Success!')),
        );
      },
      onError: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      onMismatch: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            title: const Text('Security Alert', style: TextStyle(color: Colors.white)),
            content: const Text(
              'The new performance key and confirmation key do not match. Please verify and try again.',
              style: TextStyle(color: Color(0xFF8E8E8E)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Color(0xFFD4FF00))),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChangePasswordViewModel>();

    const backgroundColor = Color(0xFF0C0C0C);
    const accentColor = Color(0xFFD4FF00);
    const surfaceColor = Color(0xFF1A1A1A);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E8E);
    const dangerColor = Color(0xFFE94560);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: textColor, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: textColor, size: 24),
                ],
              ),
              const SizedBox(height: 32),
              // Section Title
              Row(
                children: [
                  const Icon(Icons.lock_outline, color: accentColor, size: 14),
                  const SizedBox(width: 8),
                  const Text(
                    'SECURITY PROTOCOL',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'CHANGE PASSWORD',
                style: TextStyle(
                  color: textColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Update your biometric-linked access credentials for maximum performance security.',
                style: TextStyle(color: secondaryTextColor, fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 32),
              
              // Fields
              _buildInputField(
                label: 'CURRENT PASSWORD',
                controller: viewModel.currentPasswordController,
                obscureText: viewModel.obscureCurrent,
                onToggleVisibility: viewModel.toggleObscureCurrent,
              ),
              const SizedBox(height: 24),
              _buildInputField(
                label: 'NEW PERFORMANCE KEY',
                controller: viewModel.newPasswordController,
                obscureText: viewModel.obscureNew,
                borderColor: accentColor,
                onToggleVisibility: viewModel.toggleObscureNew,
              ),
              const SizedBox(height: 16),

              // Strength Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('KEY STRENGTH: ${viewModel.strengthText}', style: const TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                        Text('${(viewModel.strengthProgress * 100).toInt()}%', style: const TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: viewModel.strengthProgress,
                      backgroundColor: const Color(0xFF2C2C2C),
                      color: accentColor,
                      minHeight: 4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildRequirement('Min 10 characters', viewModel.hasMin10Chars, accentColor)),
                        Expanded(child: _buildRequirement('Special symbol', viewModel.hasSpecialSymbol, accentColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildRequirement('Numeric value', viewModel.hasNumericValue, accentColor)),
                        Expanded(child: _buildRequirement('Uppercase delta', viewModel.hasUppercase, accentColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (viewModel.showMismatchError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Passwords do not match',
                    style: TextStyle(color: dangerColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),

              _buildInputField(
                label: 'CONFIRM NEW KEY',
                controller: viewModel.confirmPasswordController,
                obscureText: viewModel.obscureConfirm,
                borderColor: viewModel.showMismatchError ? dangerColor : null,
                onToggleVisibility: viewModel.toggleObscureConfirm,
              ),
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading ? null : () => _handleUpdate(viewModel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('AUTHORIZE UPDATE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                            SizedBox(width: 8),
                            Icon(Icons.lock, color: Colors.black, size: 16),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      viewModel.newPasswordController.clear();
                      viewModel.confirmPasswordController.clear();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2C2C2C)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('CANCEL REQUEST', style: TextStyle(color: Color(0xFFB0B0B0), fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),

              // Footer Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Integrity', style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      'Changing your performance key will log out all other active training sessions across devices. This ensures your biometrics and goals remain synchronized only with your current hardware.',
                      style: TextStyle(color: secondaryTextColor, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: dangerColor, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        const Text('END-TO-END ENCRYPTED', style: TextStyle(color: dangerColor, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Color? borderColor,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF666666), fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2),
          cursorColor: const Color(0xFFD4FF00),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF141414),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: onToggleVisibility != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: borderColor ?? const Color(0xFF444444),
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor ?? Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor ?? const Color(0xFFD4FF00), width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirement(String text, bool isChecked, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isChecked ? accentColor : const Color(0xFF444444),
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: isChecked ? accentColor : const Color(0xFF666666), fontSize: 11)),
        ],
      ),
    );
  }
}
