import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/user_view_model.dart';
import 'create_profile_screen.dart';
import 'forgot_password_screen.dart';
import 'user_dashboard.dart';
import 'admin_panel_screen.dart';

class FitLogLogin extends StatefulWidget {
  const FitLogLogin({super.key});

  @override
  State<FitLogLogin> createState() => _FitLogLoginState();
}

class _FitLogLoginState extends State<FitLogLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    final viewModel = context.read<UserViewModel>();
    final result = await viewModel.login(email, password);

    if (result['userId']!.isNotEmpty) {
      if (!mounted) return;
      if (result['role'] == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.error ?? 'Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF0C0C0C);
    const Color accentColor = Color(0xFFCCFF00);
    const Color cardColor = Color(0xFF141414);

    final isLoading = context.watch<UserViewModel>().loading;

    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'FITLOG',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 48),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                  children: [
                    TextSpan(text: 'LOGIN\n', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'PROTOCOL', style: TextStyle(color: accentColor)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter your credentials to access the training grid.',
                style: TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),
              _buildInputField(
                label: 'EMAIL ADDRESS',
                hint: 'athlete@forge.com',
                controller: _emailController,
                cardColor: cardColor,
              ),
              const SizedBox(height: 24),
              _buildInputField(
                label: 'ACCESS KEY',
                hint: '********',
                controller: _passwordController,
                cardColor: cardColor,
                isPassword: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF8E8E93),
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ACCESS SYSTEM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.bolt, color: Colors.black),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "DON'T HAVE AN ACCOUNT?",
                      style: TextStyle(
                        color: Color(0xFF8E8E8E),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreateProfileScreen()),
                        );
                      },
                      child: const Text(
                        'INITIALIZE REGISTRATION',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required Color cardColor,
    bool isPassword = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && _obscurePassword,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF3A3A3C), fontSize: 16),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
