import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: BMICalculatorScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  // Controllers to capture user input
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // State variables for output
  double? _bmiResult;
  String _bmiCategory = "";
  String _bmiFeedback = "Enter your metrics above to calculate your current score.";
  double _progressValue = 0.0; // From 0.0 to 1.0 for the progress bar

  // Custom Neon Colors based on design
  static const Color bgColor = Color(0xFF121212);
  static const Color cardBgColor = Color(0xFF1E1E1E);
  static const Color neonLime = Color(0xFFCCFF00);
  static const Color textGray = Color(0xFF8E8E93);

  // Business Logic Function
  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid height and weight values.')),
      );
      return;
    }

    // BMI Formula: kg / (m^2)
    double heightInMeters = height / 100;
    double bmi = weight / pow(heightInMeters, 2);

    setState(() {
      _bmiResult = bmi;

      // Determine categories, dynamic text, and progress bar width
      if (bmi < 18.5) {
        _bmiCategory = "UNDERWEIGHT";
        _bmiFeedback = "Based on your height and weight, you are below the standard range. Consider a nutrition plan.";
        _progressValue = 0.3;
      } else if (bmi >= 18.5 && bmi < 25) {
        _bmiCategory = "NORMAL";
        _bmiFeedback = "Based on your height and weight, you are in a healthy, optimal range. Keep maintaining your lifestyle!";
        _progressValue = 0.5;
      } else if (bmi >= 25 && bmi < 30) {
        _bmiCategory = "OVERWEIGHT";
        _bmiFeedback = "Based on your height and weight, you are within the athletic-overweight range. Focus on body composition.";
        _progressValue = 0.75;
      } else {
        _bmiCategory = "OBESE";
        _bmiFeedback = "Based on your height and weight, you are within the obese range. Focus on active cardio and dietary adjustments.";
        _progressValue = 1.0;
      }
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Swipe right to go back logic
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 500) {
          // Trigger back navigation
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Custom App Bar Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    const Text(
                      'FITLOG',
                      style: TextStyle(
                        color: neonLime,
                        fontSize: 24,
                        fontWeight: FontWeight.black,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: cardBgColor,
                      child: Icon(Icons.person, color: textGray, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Section Headers
                const Text(
                  'PERFORMANCE METRICS',
                  style: TextStyle(
                    color: neonLime,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'BMI CALCULATOR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),

                // Input Card Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        label: 'HEIGHT (CM)',
                        hint: '180',
                        suffix: 'CM',
                        controller: _heightController,
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        label: 'WEIGHT (KG)',
                        hint: '85',
                        suffix: 'KG',
                        controller: _weightController,
                      ),
                      const SizedBox(height: 24),

                      // Calculate Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: neonLime,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: _calculateBMI,
                          child: const Text(
                            'CALCULATE RESULT',
                            style: TextStyle(
                              fontWeight: FontWeight.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Results Card Container (Only styled brightly if score exists)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _bmiResult != null ? neonLime : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'YOUR CURRENT SCORE',
                        style: TextStyle(
                          color: textGray,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _bmiResult != null ? _bmiResult!.toStringAsFixed(1) : '--.-',
                        style: const TextStyle(
                          color: neonLime,
                          fontSize: 54,
                          fontWeight: FontWeight.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        _bmiCategory.isNotEmpty ? _bmiCategory : 'AWAITING INPUT',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Custom Linear Progress Indicator Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progressValue,
                          minHeight: 8,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(neonLime),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _bmiFeedback,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: textGray,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Helper widget for building input text fields
  Widget _buildInputField({
    required String label,
    required String hint,
    required String suffix,
    required TextEditingController controller
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: textGray, fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              child: Text(
                suffix,
                style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            filled: true,
            fillColor: Colors.black25,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white12, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: neonLime, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}