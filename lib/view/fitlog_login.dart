import 'package:fitlog/view/register_screen.dart';
import 'package:fitlog/view/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../viewmodel/user_view_model.dart';
import 'admin_panel_screen.dart';
import 'forgot_password_screen.dart';
import 'terms_and_conditions_screen.dart';
import 'user_dashboard.dart';

class FitLogLogin extends StatefulWidget {
  const FitLogLogin({super.key});

  @override
  State<FitLogLogin> createState() => _FitLogLoginState();
}

class _FitLogLoginState extends State<FitLogLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return;
    }

    final viewModel = context.read<UserViewModel>();

    final Map<String, String> authResult = await viewModel.login(email, password);
    final String userId = authResult["userId"] ?? "";
    final String userRole = authResult["role"] ?? "user";

    print("DEBUG userId: '$userId'");
    print("DEBUG userRole: '$userRole'");

    if (!mounted) return;

    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.error ?? 'Login Failed!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Welcome back!");

      if (userRole.trim().toLowerCase() == 'admin') {
        print("DEBUG: Navigating to AdminPanelScreen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPanelScreen(),
          ),
        );
      } else {
        print("DEBUG: Navigating to DashboardScreen");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((UserViewModel vm) => vm.loading);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter credentials to access the training grid.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(height: 40),
              const _FieldLabel(label: 'EMAIL ADDRESS', size: 16),
              const SizedBox(height: 8),
              _CustomTextField(
                hint: 'NAME@SERVICE.COM',
                icon: Icons.email_outlined,
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _FieldLabel(label: 'PASSWORD', size: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
              _CustomTextField(
                hint: '********',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => _handleLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCCFF00),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ),


              const SizedBox(height: 40),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text('NEW TO THE Fitlog? ',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Color(0xFFCCFF00),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final double size;
  const _FieldLabel({required this.label, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white70,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController widgetController;

  const _CustomTextField({
    required this.hint,
    required this.icon,
    required TextEditingController controller,
    this.isPassword = false,
  }) : widgetController = controller;

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.widgetController,
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 16),
        prefixIcon: Icon(widget.icon, color: Colors.white54, size: 22),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white54,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}