import 'package:flutter/material.dart';

class FuelLogScreen extends StatefulWidget {
  const FuelLogScreen({super.key});

  @override
  State<FuelLogScreen> createState() => _FuelLogScreenState();
}

class _FuelLogScreenState extends State<FuelLogScreen> {
  static const Color backgroundColor = Color(0xFF0C0C0C);
  static const Color accentColor = Color(0xFFD4FF00);
  static const Color cardColor = Color(0xFF141414);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFF8E8E8E);
  static const Color orangeColor = Color(0xFFFF5A1F);
  static const Color cyanColor = Color(0xFF00E5FF);

  // Data starts at 0 for all meals
  Map<String, double> meals = {
    'Breakfast': 0,
    'Lunch': 0,
    'Dinner': 0,
    'Snacks': 0,
  };

  DateTime _lastResetDate = DateTime.now();
  final double targetIntake = 2500; // Customizable daily goal

  @override
  void initState() {
    super.initState();
    _checkDailyReset();
  }

  // Resets data if the current date is different from the last tracked date
  void _checkDailyReset() {
    final now = DateTime.now();
    if (now.day != _lastResetDate.day || 
        now.month != _lastResetDate.month || 
        now.year != _lastResetDate.year) {
      setState(() {
        meals = {
          'Breakfast': 0,
          'Lunch': 0,
          'Dinner': 0,
          'Snacks': 0,
        };
        _lastResetDate = now;
      });
    }
  }

  double get totalIntakeKcal => meals.values.fold(0, (sum, cal) => sum + cal);

  void _showCalorieInput(String mealTitle) {
    final calorieController = TextEditingController(text: meals[mealTitle] == 0 ? "" : meals[mealTitle]!.toInt().toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update $mealTitle',
              style: const TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 24),
            _buildInputField('Calories (kcal)', calorieController, accentColor),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    meals[mealTitle] = double.tryParse(calorieController.text) ?? 0;
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'SAVE MEAL',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: textColor, fontSize: 18),
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.3)),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF333333))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _checkDailyReset();
    final double intake = totalIntakeKcal;
    final double remaining = (targetIntake - intake).clamp(0, targetIntake);

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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF333333)),
                      color: cardColor,
                    ),
                    child: const Icon(Icons.person_outline, color: Colors.grey, size: 24),
                  ),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: textColor, size: 24),
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
                    const Text(
                      'DAILY INTAKE',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              intake.toInt().toString(),
                              style: const TextStyle(
                                color: accentColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                'kcal',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'REMAINING',
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '${remaining.toInt()} kcal',
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Intake Progress (Burned section removed)
                    _buildIntakeProgress(
                      label: 'DAILY GOAL PROGRESS',
                      value: intake.toInt().toString(),
                      progress: (intake / targetIntake).clamp(0.0, 1.0),
                      color: orangeColor,
                      subLeft: '${((intake / targetIntake) * 100).toInt()}% CONSUMED',
                      subRight: '${targetIntake.toInt()} kcal LIMIT',
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FUEL LOG',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          _getFormattedDate(),
                          style: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildFuelItem(
                      title: 'Breakfast',
                      subtitle: meals['Breakfast']! > 0 ? 'Fuel for the morning' : 'Tap to log morning meal',
                      calories: meals['Breakfast']!.toInt().toString(),
                      onTap: () => _showCalorieInput('Breakfast'),
                    ),
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Lunch',
                      subtitle: meals['Lunch']! > 0 ? 'Fuel for the afternoon' : 'Tap to log lunch',
                      calories: meals['Lunch']!.toInt().toString(),
                      onTap: () => _showCalorieInput('Lunch'),
                    ),
                    const SizedBox(height: 12),
                    _buildDinnerItem(),
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Snacks',
                      subtitle: meals['Snacks']! > 0 ? 'Additional fuel' : 'Tap to log snacks',
                      calories: meals['Snacks']!.toInt().toString(),
                      onTap: () => _showCalorieInput('Snacks'),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: accentColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 2,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dash'),
          const BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Train'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.restaurant_menu, color: Colors.black),
            ),
            label: 'Fuel',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Goals'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Admin'),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  Widget _buildDinnerItem() {
    bool hasData = meals['Dinner']! > 0;
    
    if (hasData) {
      return _buildFuelItem(
        title: 'Dinner',
        subtitle: 'Fuel for the evening',
        calories: meals['Dinner']!.toInt().toString(),
        onTap: () => _showCalorieInput('Dinner'),
      );
    }

    return GestureDetector(
      onTap: () => _showCalorieInput('Dinner'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant, color: Colors.grey, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dinner',
                    style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Not logged yet',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '--',
              style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntakeProgress({
    required String label,
    required String value,
    required double progress,
    required Color color,
    required String subLeft,
    required String subRight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: secondaryTextColor, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subLeft, style: const TextStyle(color: secondaryTextColor, fontSize: 8, fontWeight: FontWeight.bold)),
            Text(subRight, style: const TextStyle(color: secondaryTextColor, fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildFuelItem({
    required String title,
    required String subtitle,
    required String calories,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant, color: Colors.grey, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: secondaryTextColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calories,
                  style: const TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'KCAL',
                  style: TextStyle(color: secondaryTextColor, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),
            const Icon(Icons.chevron_right, color: Color(0xFF333333), size: 18),
          ],
        ),
      ),
    );
  }
}
