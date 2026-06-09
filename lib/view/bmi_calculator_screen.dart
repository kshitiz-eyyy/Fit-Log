import 'package:flutter/material.dart';
import 'bmi_brain.dart';

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
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmiResult;
  String _bmiCategory = "";
  String _bmiFeedback = "Enter your metrics above to calculate your current score.";
  double _progressValue = 0.0;

  static const Color bgColor = Color(0xFF121212);
  static const Color cardBgColor = Color(0xFF1E1E1E);
  static const Color inputBgColor = Color(0xFF161616);
  static const Color neonLime = Color(0xFFCCFF00);
  static const Color textGray = Color(0xFF8E8E93);

  void _executeCalculation() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid height and weight values.')),
      );
      return;
    }

    BMIBrain brain = BMIBrain(height: height, weight: weight);
    double bmi = brain.calculateBMI();

    setState(() {
      _bmiResult = bmi;
      _bmiCategory = brain.getCategory(bmi);
      _bmiFeedback = brain.getFeedback(bmi);
      _progressValue = brain.getProgressValue(bmi);
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
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 500) {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/newbmi.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.45),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          fontWeight: FontWeight.w900,
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
                  const Text(
                    'PERFORMANCE METRICS',
                    style: TextStyle(
                      color: neonLime,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(offset: Offset(0, 1), blurRadius: 4.0, color: Colors.black),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'BMI CALCULATOR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(offset: Offset(0, 1), blurRadius: 4.0, color: Colors.black),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBgColor.withValues(alpha: 0.92),
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
                            onPressed: _executeCalculation,
                            child: const Text(
                              'CALCULATE RESULT',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardBgColor.withValues(alpha: 0.92),
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
                            fontWeight: FontWeight.w900,
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
      ),
    );
  }

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
            fillColor: inputBgColor,
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