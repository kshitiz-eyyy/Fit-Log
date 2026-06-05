import 'package:flutter/material.dart';

class CalorieTrackerScreen extends StatefulWidget {
  const CalorieTrackerScreen({super.key});

  @override
  State<CalorieTrackerScreen> createState() => _CalorieTrackerScreenState();
}

class _CalorieTrackerScreenState extends State<CalorieTrackerScreen> {
  final Map<String, int> _mealCalories = {
    'Breakfast': 450,
    'Lunch': 620,
    'Dinner': 0,
    'Snack': 150,
  };

  int get _totalCalories => _mealCalories.values.fold(0, (sum, val) => sum + val);
  final int _goalCalories = 2000;

  void _showEditCaloriesDialog(String mealName) {
    final TextEditingController controller = TextEditingController(
      text: _mealCalories[mealName].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: Text('Edit $mealName Calories', style: const TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Calories',
            labelStyle: TextStyle(color: Color(0xFFD0FD3E)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD0FD3E))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _mealCalories[mealName] = int.tryParse(controller.text) ?? 0;
              });
              Navigator.pop(context);
            },
            child: const Text('SAVE', style: TextStyle(color: Color(0xFFD0FD3E))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.black;
    const cardBackgroundColor = Color(0xFF1C1C1E);
    const accentColor = Color(0xFFD0FD3E);
    const orangeColor = Color(0xFFFF5A1F);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'FIT LOG',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(Icons.dashboard_outlined, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Calorie Tracker',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Calorie Ring
            Center(
              child: SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: _totalCalories / _goalCalories,
                        strokeWidth: 12,
                        backgroundColor: const Color(0xFF333333),
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_totalCalories',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '/ $_goalCalories KCAL',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Today's Total",
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Meals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MEALS TODAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${_mealCalories.length} ENTRIES',
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMealItem('Breakfast', _mealCalories['Breakfast']!, cardBackgroundColor),
            const SizedBox(height: 12),
            _buildMealItem('Lunch', _mealCalories['Lunch']!, cardBackgroundColor),
            const SizedBox(height: 12),
            _buildMealItem('Dinner', _mealCalories['Dinner']!, cardBackgroundColor),
            const SizedBox(height: 12),
            _buildMealItem('Snack', _mealCalories['Snack']!, cardBackgroundColor),
            const SizedBox(height: 32),
            // Log Meal Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: orangeColor,
                  shape: RoundedCornerShape(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'LOG MEAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: accentColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildMealItem(String name, int calories, Color backgroundColor) {
    return GestureDetector(
      onTap: () => _showEditCaloriesDialog(name),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant, color: Colors.grey, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$calories kcal',
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit_outlined, color: Color(0xFF8E8E93), size: 18),
          ],
        ),
      ),
    );
  }
}

class RoundedCornerShape extends OutlinedBorder {
  final double radius;
  const RoundedCornerShape(this.radius);

  @override
  OutlinedBorder copyWith({BorderSide? side}) => RoundedCornerShape(radius);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedCornerShape(radius * t);
}
