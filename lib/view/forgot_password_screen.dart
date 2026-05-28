import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white12, width: 1),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Logo
                const Center(
                  child: Text(
                    'FITLOG',
                    style: TextStyle(
                      color: Color(0xFFCCFF00),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Reset your access to elite performance tracking.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 30),

                // Email Address
                const _FieldLabel(label: 'EMAIL ADDRESS'),
                const _CustomInput(
                  hint: 'CHAMPION@FITLOG.COM',
                  icon: Icons.email_outlined,
                  isSuffixIcon: true,
                ),

                const SizedBox(height: 16),

                // Send OTP Button
                _ActionButton(
                  text: 'SEND OTP',
                  onPressed: () {},
                  color: const Color(0xFFCCFF00),
                ),

                const SizedBox(height: 24),

                // OTP Input
                const _FieldLabel(label: 'ENTER OTP'),
                const _CustomInput(hint: 'CODE'),

                const SizedBox(height: 20),

                // New Password
                const _FieldLabel(label: 'NEW PASSWORD'),
                _CustomInput(
                  hint: '●●●●●●●●',
                  isPassword: true,
                  obscure: _obscureNew,
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
                ),

                // Confirm Password
                const _FieldLabel(label: 'CONFIRM PASSWORD'),
                _CustomInput(
                  hint: '●●●●●●●●',
                  isPassword: true,
                  obscure: _obscureConfirm,
                  onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),

                const SizedBox(height: 30),

                // Reset Password Button
                _ActionButton(
                  text: 'RESET PASSWORD',
                  onPressed: () {},
                  color: const Color(0xFFCCFF00),
                ),

                const SizedBox(height: 24),

                // Back to Login
                Center(
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.grey, size: 16),
                    label: const Text(
                      'BACK TO LOGIN',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Components
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final bool obscure;
  final bool isSuffixIcon;
  final VoidCallback? onToggle;

  const _CustomInput({
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.obscure = false,
    this.isSuffixIcon = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(color: Colors.white, letterSpacing: 2),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
            onPressed: onToggle,
          )
              : (isSuffixIcon ? Icon(icon, color: Colors.white54) : null),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}