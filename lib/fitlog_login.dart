import 'package:fitlog/register_screen.dart';
import 'package:flutter/material.dart';

class FitLogLogin extends StatelessWidget {
  const FitLogLogin({super.key});

  @override
  Widget build(BuildContext context) {
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
              // --- INCREASED SIZE: Credentials Subtitle ---
              const Text(
                'Enter credentials to access the training grid.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(height: 40),


              const _FieldLabel(label: 'EMAIL ADDRESS', size: 16),
              const SizedBox(height: 8),
              const _CustomTextField(
                hint: 'NAME@SERVICE.COM',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 24),

              // Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const _FieldLabel(label: 'PASSWORD', size: 16),
                  TextButton(
                    onPressed: () {},
                    // --- INCREASED SIZE: Forgot Password ---
                    child: const Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const _CustomTextField(
                hint: '********',
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              const SizedBox(height: 32),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCCFF00),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Row(
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
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR CONNECT WITH',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.white12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
                    SizedBox(width: 8),
                    Text('GOOGLE', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- INCREASED SIZE: New to the Rig footer ---
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text('NEW TO THE Fitlog? ',
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        // This command pushes the RegisterScreen on top of the LoginScreen
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

// Reusable Label Widget (Updated with size parameter)
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

// Reusable TextField Widget
class _CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;

  const _CustomTextField({
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  // Local state to track visibility
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Start hidden if it's a password field
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 16),
        prefixIcon: Icon(widget.icon, color: Colors.white54, size: 22),

        // Add the toggle icon only if isPassword is true
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