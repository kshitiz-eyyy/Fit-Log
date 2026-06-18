import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  // Controllers
  final TextEditingController _passwordController = TextEditingController();

  // Colors from the design
  static const Color darkBackground = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color primaryOrange = Color(0xFFFF6D00);
  static const Color secondaryLime = Color(0xFFC6FF00);
  static const Color textGray = Color(0xFFBDBDBD);
  static const Color indicatorGray = Color(0xFF333333);

  String _selectedGoal = 'Muscle Gain';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateState);
    _passwordController.dispose();
    super.dispose();
  }

  // Password Strength Logic from ChangePasswordScreen
  bool get _hasMin10Chars => _passwordController.text.length >= 10;
  bool get _hasSpecialSymbol =>
      _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get _hasNumericValue =>
      _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasUppercase =>
      _passwordController.text.contains(RegExp(r'[A-Z]'));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'FIT LOG',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CREATE YOUR\nPROFILE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Step into the high-intensity world of precision fitness.',
              style: TextStyle(
                color: textGray,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildLabel('FULL NAME'),
            _buildTextField(hint: 'Enter your name'),
            const SizedBox(height: 20),

            _buildLabel('EMAIL'),
            _buildTextField(hint: 'email@example.com'),
            const SizedBox(height: 20),

            _buildLabel('PASSWORD'),
            _buildTextField(
              hint: 'Min. 10 characters, special symbols...',
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 12),

            // Password strength indicator
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('KEY STRENGTH: $_strengthText',
                          style: const TextStyle(
                              color: secondaryLime,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      Text('${(_strengthProgress * 100).toInt()}%',
                          style: const TextStyle(
                              color: secondaryLime,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _strengthProgress,
                    backgroundColor: const Color(0xFF2C2C2C),
                    color: secondaryLime,
                    minHeight: 4,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildRequirement(
                              'Min 10 chars', _hasMin10Chars)),
                      Expanded(
                          child: _buildRequirement(
                              'Special symbol', _hasSpecialSymbol)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildRequirement(
                              'Numeric value', _hasNumericValue)),
                      Expanded(
                          child: _buildRequirement(
                              'Uppercase', _hasUppercase)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Age and Gender
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('AGE'),
                      _buildDropdownField('25'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('GENDER'),
                      _buildDropdownField('Male', isSelect: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Height and Weight
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('HEIGHT (CM)'),
                      _buildDropdownField('180'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('WEIGHT (KG)'),
                      _buildDropdownField('75'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _buildLabel('FITNESS GOAL'),
            _buildGoalItem(
              title: 'Muscle Gain',
              icon: Icons.fitness_center,
              isSelected: _selectedGoal == 'Muscle Gain',
              onTap: () => setState(() => _selectedGoal = 'Muscle Gain'),
            ),
            _buildGoalItem(
              title: 'Weight Loss',
              icon: Icons.directions_run,
              isSelected: _selectedGoal == 'Weight Loss',
              onTap: () => setState(() => _selectedGoal = 'Weight Loss'),
            ),
            _buildGoalItem(
              title: 'Endurance',
              icon: Icons.bolt,
              isSelected: _selectedGoal == 'Endurance',
              onTap: () => setState(() => _selectedGoal = 'Endurance'),
            ),

            const SizedBox(height: 40),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(color: textGray, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: secondaryLime,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: textGray,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    TextEditingController? controller,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3), fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isChecked ? secondaryLime : const Color(0xFF444444),
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(
                  color: isChecked ? secondaryLime : const Color(0xFF666666),
                  fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String value, {bool isSelect = false}) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Icon(
            isSelect ? Icons.keyboard_arrow_down : Icons.unfold_more,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: secondaryLime, width: 1)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? secondaryLime : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Icon(
              icon,
              color: isSelected ? secondaryLime : Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
