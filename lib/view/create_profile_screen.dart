import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _handleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _accessKeyController = TextEditingController();
  final TextEditingController _verifyKeyController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C0C0C);
    const accentColor = Color(0xFFD4FF00);
    const cardColor = Color(0xFF141414);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E8E);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: textColor, size: 24),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 24), // For symmetry
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          fontFamily: 'Roboto', // Defaulting to system
                        ),
                        children: [
                          TextSpan(text: 'CREATE\n', style: TextStyle(color: textColor)),
                          TextSpan(text: 'PROFILE', style: TextStyle(color: accentColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Establish your athletic identifier for the ecosystem.',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Profile Image
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cardColor,
                              border: Border.all(color: const Color(0xFF333333)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildInputField(
                      label: 'ATHLETE HANDLE',
                      hint: 'Username',
                      controller: _handleController,
                      cardColor: cardColor,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'EMAIL PROTOCOL',
                      hint: 'email@forge.performance',
                      controller: _emailController,
                      cardColor: cardColor,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'COMMS LINK (PHONE)',
                      hint: '+1 (555) 000-0000',
                      controller: _phoneController,
                      cardColor: cardColor,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'ACCESS KEY',
                      hint: '********',
                      controller: _accessKeyController,
                      cardColor: cardColor,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'VERIFY KEY',
                      hint: '********',
                      controller: _verifyKeyController,
                      cardColor: cardColor,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'ATHLETIC OBJECTIVE (BIO)',
                      hint: 'Tell us about your performance goals...',
                      controller: _bioController,
                      cardColor: cardColor,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    // Terms
                    GestureDetector(
                      onTap: () => setState(() => _termsAccepted = !_termsAccepted),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _termsAccepted ? accentColor : const Color(0xFF3A3A3C),
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: _termsAccepted ? accentColor : Colors.transparent,
                            ),
                            child: _termsAccepted
                                ? const Icon(Icons.check, color: Colors.black, size: 14)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: textColor),
                              children: [
                                TextSpan(text: 'Accept '),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'INITIALIZE PERFORMANCE',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.black, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'STEP 01 / 03',
                        style: TextStyle(
                          color: Color(0xFF48484A),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
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
    int maxLines = 1,
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
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF3A3A3C), fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
