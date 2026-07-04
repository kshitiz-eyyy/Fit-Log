import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/calorie_tracker_viewmodel.dart';
import '../repo/calorie_repository.dart';
import '../model/meal_model.dart';

class CalorieTrackerScreen extends StatelessWidget {
  const CalorieTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalorieTrackerViewModel(CalorieRepositoryImpl()),
      child: const _CalorieTrackerView(),
    );
  }
}

class _CalorieTrackerView extends StatelessWidget {
  const _CalorieTrackerView();

  void _showEditCaloriesDialog(BuildContext context, Meal meal) {
    final viewModel = context.read<CalorieTrackerViewModel>();
    final TextEditingController controller = TextEditingController(
      text: meal.calories.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: Text('Edit ${meal.name} Calories', style: const TextStyle(color: Colors.white)),
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
              viewModel.updateMealCalories(meal.name, int.tryParse(controller.text) ?? 0);
              Navigator.pop(context);
            },
            child: const Text('SAVE', style: TextStyle(color: Color(0xFFD0FD3E))),
          ),
        ],
      ),
    );
  }

  void _showAddMealDialog(BuildContext context) {
    final viewModel = context.read<CalorieTrackerViewModel>();
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text('Log New Meal', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Meal Name (e.g., Afternoon Snack)',
                labelStyle: TextStyle(color: Color(0xFF8E8E93)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD0FD3E))),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Calories',
                labelStyle: TextStyle(color: Color(0xFF8E8E93)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD0FD3E))),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                viewModel.updateMealCalories(
                  nameController.text,
                  int.tryParse(caloriesController.text) ?? 0,
                );
              }
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

    final viewModel = context.watch<CalorieTrackerViewModel>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator(color: accentColor))
          : RefreshIndicator(
              onRefresh: viewModel.fetchMeals,
              color: accentColor,
              backgroundColor: cardBackgroundColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                                value: (viewModel.totalCalories / viewModel.goalCalories).clamp(0.0, 1.0),
                                strokeWidth: 12,
                                backgroundColor: const Color(0xFF333333),
                                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${viewModel.totalCalories}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '/ ${viewModel.goalCalories} KCAL',
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
                          '${viewModel.meals.length} ENTRIES',
                          style: const TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...viewModel.meals.map((meal) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildMealItem(context, meal, cardBackgroundColor),
                        )),
                    const SizedBox(height: 32),
                    // Log Meal Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _showAddMealDialog(context),
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(context),
        backgroundColor: accentColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildMealItem(BuildContext context, Meal meal, Color backgroundColor) {
    return GestureDetector(
      onTap: () => _showEditCaloriesDialog(context, meal),
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
                  meal.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${meal.calories} kcal',
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

