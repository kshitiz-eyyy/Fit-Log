import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/user_view_model.dart';
import '../model/user_model.dart';
import 'terms_and_conditions_screen.dart';
import 'fitlog_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  bool _isAgreed = false;
  bool _obscurePw = true;
  bool _obscureConfirmPw = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final contact = _contactController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || contact.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final viewModel = context.read<UserViewModel>();
    final userId = await viewModel.register(email, password);

    if (userId.isNotEmpty) {
      final userModel = UserModel(
        id: userId,
        name: name,
        contact: contact,
        email: email,
      );

      final success = await viewModel.addUser(userModel);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const FitLogLogin()),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(viewModel.error ?? 'Failed to save user data')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.error ?? 'Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<UserViewModel>().loading;
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
                controller: _nameController,
              ),

              // Email Address
              const _FieldLabel(label: 'EMAIL ADDRESS'),
              _CustomInput(
                hint: 'ENTER EMAIL',
                icon: Icons.email_outlined,
                controller: _emailController,
              ),

              // Contact Number
              const _FieldLabel(label: 'CONTACT NUMBER'),
              _CustomInput(
                hint: 'ENTER CONTACT',
                icon: Icons.phone_outlined,
                controller: _contactController,
              ),

              // Password
              const _FieldLabel(label: 'PASSWORD'),
              _CustomInput(
                hint: '●●●●●●●●',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: _obscurePw,
                controller: _passwordController,
                onToggle: () => setState(() => _obscurePw = !_obscurePw),
              ),

              // Confirm Password
              const _FieldLabel(label: 'CONFIRM PASSWORD'),
              _CustomInput(
                hint: '●●●●●●●●',
                icon: Icons.lock_outline,
                isPassword: true,
                obscure: _obscureConfirmPw,
                controller: _confirmPasswordController,
                onToggle: () => setState(() => _obscureConfirmPw = !_obscureConfirmPw),
              ),

              const SizedBox(height: 20),

              // Terms & Conditions Checkbox
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
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        children: [
                          const TextSpan(text: 'I AGREE TO THE '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: () async {
                                final bool? accepted = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsAndConditionsScreen(),
                                  ),
                                );

                                if (accepted == true) {
                                  setState(() {
                                    _isAgreed = true;
                                  });
                                }
                              },
                              child: const Text(
                                'TERMS & CONDITIONS',
                                style: TextStyle(
                                  color: Color(0xFFCCFF00),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Create Account Button (Locks/Unlocks dynamically)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_isAgreed && !isLoading) ? _handleRegister : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isAgreed ? const Color(0xFFCCFF00) : const Color(0xFF1E1E1E),
                    disabledBackgroundColor: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: _isAgreed ? Colors.black : Colors.white24,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: _isAgreed ? Colors.black : Colors.white24,
                      ),
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
                        Navigator.maybePop(context);
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
  final TextEditingController controller;

  const _CustomInput({
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.obscure = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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