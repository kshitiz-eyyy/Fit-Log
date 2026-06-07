import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController(text: 'password123');
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updateState);
    _confirmPasswordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_updateState);
    _confirmPasswordController.removeListener(_updateState);
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMin10Chars => _newPasswordController.text.length >= 10;
  bool get _hasSpecialSymbol =>
      _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get _hasNumericValue =>
      _newPasswordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasUppercase =>
      _newPasswordController.text.contains(RegExp(r'[A-Z]'));

  bool get _passwordsMatch => _newPasswordController.text == _confirmPasswordController.text;
  bool get _showMismatchError => _confirmPasswordController.text.isNotEmpty && !_passwordsMatch;

  double get _strengthProgress {
    int count = 0;
    if (_hasMin10Chars) count++;
    if (_hasSpecialSymbol) count++;
    if (_hasNumericValue) count++;
    if (_hasUppercase) count++;
    return count / 4;
  }

  String get _strengthText {
    double progress = _strengthProgress;
    if (progress >= 1.0) return 'ELITE';
    if (progress >= 0.75) return 'STRONG';
    if (progress >= 0.5) return 'FAIR';
    if (progress >= 0.25) return 'WEAK';
    return 'NONE';
  }

  void _handleAuthorizeUpdate() {
    if (!_passwordsMatch) {
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
    } else if (_strengthProgress < 1.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please meet all security requirements.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updating password... Success!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C0C0C);
    const accentColor = Color(0xFFD4FF00);
    const surfaceColor = Color(0xFF1A1A1A);
    const inputColor = Color(0xFF141414);
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
                  Text(
                    'SECURITY PROTOCOL',
                    style: const TextStyle(
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
                controller: _currentPasswordController,
                obscureText: _obscureCurrent,
                onToggleVisibility: () => setState(() => _obscureCurrent = !_obscureCurrent),
              ),
              const SizedBox(height: 24),
              _buildInputField(
                label: 'NEW PERFORMANCE KEY',
                controller: _newPasswordController,
                obscureText: _obscureNew,
                borderColor: accentColor,
                onToggleVisibility: () => setState(() => _obscureNew = !_obscureNew),
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
                        Text('KEY STRENGTH: $_strengthText', style: const TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                        Text('${(_strengthProgress * 100).toInt()}%', style: const TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _strengthProgress,
                      backgroundColor: const Color(0xFF2C2C2C),
                      color: accentColor,
                      minHeight: 4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildRequirement('Min 10 characters', _hasMin10Chars, accentColor)),
                        Expanded(child: _buildRequirement('Special symbol', _hasSpecialSymbol, accentColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildRequirement('Numeric value', _hasNumericValue, accentColor)),
                        Expanded(child: _buildRequirement('Uppercase delta', _hasUppercase, accentColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (_showMismatchError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Passwords do not match',
                    style: TextStyle(color: dangerColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),

              _buildInputField(
                label: 'CONFIRM NEW KEY',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                borderColor: _showMismatchError ? dangerColor : null,
                onToggleVisibility: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleAuthorizeUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
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
                      setState(() {
                        _newPasswordController.clear();
                        _confirmPasswordController.clear();
                      });
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
              const SizedBox(height: 32), // Extra space at bottom
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
