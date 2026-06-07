import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Added for feedback toasts
import 'package:provider/provider.dart';       // Added to watch the view model

import '../model/user_model.dart';
import '../viewmodel/user_view_model.dart';         // Adjust based on your model path

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isAgreed = false;
  bool _obscurePw = true;
  bool _obscureConfirmPw = true;

  // 1. ADD CONTROLLERS TO MANAGE THE USER INPUT
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when widget is destroyed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 2. BACKEND INTEGRATION HANDLER
  void _handleRegistration(UserViewModel viewModel) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    // Basic Form Validations
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all details");
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return;
    }

    if (!_isAgreed) {
      Fluttertoast.showToast(msg: "You must agree to the Terms & Conditions");
      return;
    }

    // Step A: Register User in Firebase Authentication
    final String userId = await viewModel.register(email, password);

    if (userId.isEmpty) {
      // Show Firebase registration failure error
      Fluttertoast.showToast(msg: viewModel.error ?? "Registration failed");
    } else {
      // Step B: Formulate UserModel matching your teacher's structure
      final userProfile = UserModel(
        id: userId,
        name: name,
        email: email,
        contact: null, // Left as optional null value since UI has no phone field
      );

      // Step C: Save user metadata into Cloud Firestore Database
      final bool dbSuccess = await viewModel.addUser(userProfile);

      if (dbSuccess) {
        Fluttertoast.showToast(msg: "Registration success!");
        Navigator.pop(context); // Clear registration view and go back to login screen
      } else {
        Fluttertoast.showToast(msg: viewModel.error ?? "Failed to save profile context");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 3. LISTEN TO THE USER VIEW MODEL PROVIDER
    final viewModel = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
              const SizedBox(height: 40),

              const Text(
                'CREATE ACCOUNT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your details to start your performance journey.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Full Name
              const _FieldLabel(label: 'FULL NAME'),
              _CustomInput(
                hint: 'ENTER NAME',
                icon: Icons.person_outline,
                controller: _nameController, // Pass matching controller
              ),

              // Email Address
              const _FieldLabel(label: 'EMAIL ADDRESS'),
              _CustomInput(
                hint: 'ENTER EMAIL',
                icon: Icons.email_outlined,
                controller: _emailController, // Pass matching controller
              ),

              // Password
              const _FieldLabel(label: 'PASSWORD'),
              _CustomInput(
                hint: '●●●●●●●●',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: _obscurePw,
                onToggle: () => setState(() => _obscurePw = !_obscurePw),
                controller: _passwordController, // Pass matching controller
              ),

              // Confirm Password
              const _FieldLabel(label: 'CONFIRM PASSWORD'),
              _CustomInput(
                hint: '●●●●●●●●',
                icon: Icons.history,
                isPassword: true,
                obscure: _obscureConfirmPw,
                onToggle: () => setState(() => _obscureConfirmPw = !_obscureConfirmPw),
                controller: _confirmPasswordController, // Pass matching controller
              ),

              const SizedBox(height: 20),

              // Terms & Conditions
              Row(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white24),
                    child: Checkbox(
                      value: _isAgreed,
                      activeColor: const Color(0xFFCCFF00),
                      checkColor: Colors.black,
                      onChanged: (val) => setState(() => _isAgreed = val!),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        children: [
                          TextSpan(text: 'I AGREE TO THE '),
                          TextSpan(
                            text: 'TERMS & CONDITIONS',
                            style: TextStyle(
                              color: Color(0xFFCCFF00),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Create Account Button linked with loading logic states
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: viewModel.loading ? null : () => _handleRegistration(viewModel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCCFF00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: viewModel.loading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign In Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ALREADY HAVE AN ACCOUNT? ',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Color(0xFFCCFF00),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Step Progress Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFF00),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
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
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscure;
  final VoidCallback? onToggle;
  final TextEditingController? controller; // 4. PROP TO HOOK THE CONTROLLERS

  const _CustomInput({
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.obscure = false,
    this.onToggle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // 5. INTEGRATED TEXT CONTROLLER ENGINE
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: Icon(icon, color: Colors.white54),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white54,
          ),
          onPressed: onToggle,
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