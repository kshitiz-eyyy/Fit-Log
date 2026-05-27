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

  // Initial State Data
  Map<String, Map<String, double>> meals = {
    'Breakfast': {'protein': 40, 'carbs': 50, 'fats': 10},
    'Lunch': {'protein': 60, 'carbs': 80, 'fats': 15},
    'Dinner': {'protein': 0, 'carbs': 0, 'fats': 0},
    'Snacks': {'protein': 20, 'carbs': 30, 'fats': 10},
  };

  double get totalProtein => meals.values.fold(0, (sum, meal) => sum + meal['protein']!);
  double get totalCarbs => meals.values.fold(0, (sum, meal) => sum + meal['carbs']!);
  double get totalFats => meals.values.fold(0, (sum, meal) => sum + meal['fats']!);

  double calculateKcal(Map<String, double> meal) {
    return (meal['protein']! * 4) + (meal['carbs']! * 4) + (meal['fats']! * 9);
  }

  double get totalIntakeKcal => meals.values.fold(0, (sum, meal) => sum + calculateKcal(meal));
  double burnedKcal = 2840;
  double targetIntake = 3000;

  void _showMacroInput(String mealTitle) {
    final proteinController = TextEditingController(text: meals[mealTitle]!['protein']!.toInt().toString());
    final carbsController = TextEditingController(text: meals[mealTitle]!['carbs']!.toInt().toString());
    final fatsController = TextEditingController(text: meals[mealTitle]!['fats']!.toInt().toString());

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
              'Input Macros for $mealTitle',
              style: const TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 24),
            _buildInputField('Protein (g)', proteinController, accentColor),
            const SizedBox(height: 16),
            _buildInputField('Carbs (g)', carbsController, textColor),
            const SizedBox(height: 16),
            _buildInputField('Fats (g)', fatsController, cyanColor),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    meals[mealTitle] = {
                      'protein': double.tryParse(proteinController.text) ?? 0,
                      'carbs': double.tryParse(carbsController.text) ?? 0,
                      'fats': double.tryParse(fatsController.text) ?? 0,
                    };
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'SAVE MACROS',
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
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF333333))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double intake = totalIntakeKcal;
    final double balance = intake - burnedKcal;
    final String balanceText = balance >= 0 ? '+${balance.toInt()}' : balance.toInt().toString();

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
                      'DAILY ENERGY BALANCE',
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
                              balanceText,
                              style: TextStyle(
                                color: balance >= 0 ? accentColor : orangeColor,
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
                            Text(
                              balance >= 0 ? 'SURPLUS' : 'DEFICIT',
                              style: TextStyle(
                                color: balance >= 0 ? accentColor : orangeColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  balance >= 0 ? Icons.trending_up : Icons.trending_down,
                                  color: balance >= 0 ? accentColor : orangeColor,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${((balance.abs() / burnedKcal) * 100).toInt()}%',
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
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Energy Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildEnergyStat(
                            label: 'BURNED',
                            value: burnedKcal.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                            progress: 0.85, // Dummy target progress
                            progressColor: accentColor,
                            subLeft: '85% OF TARGET',
                            subRight: '3,200 GOAL',
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildEnergyStat(
                            label: 'INTAKE',
                            value: intake.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                            valueColor: orangeColor,
                            progress: (intake / targetIntake).clamp(0.0, 1.0),
                            progressColor: orangeColor,
                            subLeft: '${((intake / targetIntake) * 100).toInt()}% OF LIMIT',
                            subRight: '${targetIntake.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} LIMIT',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'MACRONUTRIENTS',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMacroCard(
                            label: 'PROTEIN',
                            amount: '${totalProtein.toInt()}g',
                            target: '200g',
                            percent: (totalProtein / 200 * 100).toInt(),
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMacroCard(
                            label: 'CARBS',
                            amount: '${totalCarbs.toInt()}g',
                            target: '400g',
                            percent: (totalCarbs / 400 * 100).toInt(),
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMacroCard(
                            label: 'FATS',
                            amount: '${totalFats.toInt()}g',
                            target: '180g',
                            percent: (totalFats / 180 * 100).toInt(),
                            color: cyanColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'FUEL LOG',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'MAY 24, 2024',
                          style: TextStyle(
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
                      subtitle: 'Protein Oats & Berries',
                      calories: calculateKcal(meals['Breakfast']!).toInt().toString(),
                      onTap: () => _showMacroInput('Breakfast'),
                    ),
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Lunch',
                      subtitle: 'Grilled Chicken & Quinoa',
                      calories: calculateKcal(meals['Lunch']!).toInt().toString(),
                      onTap: () => _showMacroInput('Lunch'),
                    ),
                    const SizedBox(height: 12),
                    // Dinner
                    _buildDinnerItem(),
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Snacks',
                      subtitle: 'Whey Isolate & Almonds',
                      calories: calculateKcal(meals['Snacks']!).toInt().toString(),
                      onTap: () => _showMacroInput('Snacks'),
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

  Widget _buildDinnerItem() {
    bool hasData = meals['Dinner']!['protein']! > 0 || meals['Dinner']!['carbs']! > 0 || meals['Dinner']!['fats']! > 0;
    
    if (hasData) {
      return _buildFuelItem(
        title: 'Dinner',
        subtitle: 'Custom Dinner',
        calories: calculateKcal(meals['Dinner']!).toInt().toString(),
        onTap: () => _showMacroInput('Dinner'),
      );
    }

    return GestureDetector(
      onTap: () => _showMacroInput('Dinner'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x80D4FF00)),
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

  Widget _buildEnergyStat({
    required String label,
    required String value,
    Color valueColor = Colors.white,
    required double progress,
    required Color progressColor,
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
          style: TextStyle(color: valueColor, fontSize: 28, fontWeight: FontWeight.w900),
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
                  color: progressColor,
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

  Widget _buildMacroCard({
    required String label,
    required String amount,
    required String target,
    required int percent,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              children: [
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 4,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: percent / 100,
                      strokeWidth: 4,
                      color: color,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '$percent%',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(color: secondaryTextColor, fontSize: 9, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          Text(
            'of $target',
            style: const TextStyle(color: secondaryTextColor, fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
