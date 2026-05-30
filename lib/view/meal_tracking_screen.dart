import 'package:flutter/material.dart';

class MealTrackingScreen extends StatefulWidget {
  const MealTrackingScreen({super.key});

  @override
  State<MealTrackingScreen> createState() => _MealTrackingScreenState();
}

class _MealTrackingScreenState extends State<MealTrackingScreen> {
  // --- STATE VARIABLES ---
  // Tracks what the user has actually logged
  Map<String, LoggedMeal> loggedMeals = {
    "Breakfast": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Lunch": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Dinner": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Snacks": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
  };

  // Tracks what the AI recommends (Defaults to empty/pending)
  Map<String, String> aiRecommendations = {
    "Breakfast": "Pending setup...",
    "Lunch": "Pending setup...",
    "Dinner": "Pending setup...",
    "Snacks": "Pending setup...",
  };

  // Target Limits (Can be updated dynamically by AI setup later)
  int targetCalories = 2800;
  int targetProtein = 180;
  int targetCarbs = 300;
  int targetFats = 80;

  // --- GETTERS FOR TOTALS ---
  int get totalCaloriesEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.calories);
  int get totalProteinEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.protein);
  int get totalCarbsEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.carbs);
  int get totalFatsEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.fats);

  int get caloriesRemaining => targetCalories - totalCaloriesEaten;

  // --- FUNCTION: LOG A MEAL MANUAL FLOW ---
  void _openLogMealBottomSheet(String mealType) {
    final nameController = TextEditingController(text: loggedMeals[mealType]?.name);
    String selectedPortion = "1 Serving";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24, left: 24, right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log $mealType",
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              if (aiRecommendations[mealType] != "Pending setup...")
                Text(
                  "💡 AI Suggestion: ${aiRecommendations[mealType]}",
                  style: const TextStyle(color: Color(0xFFD4FF00), fontSize: 13, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 20),
              const Text("WHAT DID YOU EAT?", style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "e.g., Grilled Chicken & Rice",
                  hintStyle: const TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              const Text("PORTION SIZE", style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedPortion,
                dropdownColor: const Color(0xFF151515),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                items: ["0.5 Serving", "1 Serving", "1.5 Servings", "2 Servings"].map((val) {
                  return DropdownMenuItem(value: val, child: Text(val));
                }).toList(),
                onChanged: (val) => selectedPortion = val!,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4FF00),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) return;

                    // Parse multiplier factor based on selection
                    double factor = 1.0;
                    if (selectedPortion == "0.5 Serving") factor = 0.5;
                    if (selectedPortion == "1.5 Servings") factor = 1.5;
                    if (selectedPortion == "2 Servings") factor = 2.0;

                    // Mathematical Matrix Generation Rule (Simulating nutrition computation values per serving)
                    int baseCals = mealType == "Breakfast" ? 450 : mealType == "Lunch" ? 650 : mealType == "Dinner" ? 700 : 300;
                    int basePro = mealType == "Breakfast" ? 30 : mealType == "Lunch" ? 45 : mealType == "Dinner" ? 40 : 15;
                    int baseCarb = mealType == "Breakfast" ? 50 : mealType == "Lunch" ? 60 : mealType == "Dinner" ? 55 : 30;
                    int baseFat = mealType == "Breakfast" ? 12 : mealType == "Lunch" ? 15 : mealType == "Dinner" ? 18 : 8;

                    setState(() {
                      loggedMeals[mealType] = LoggedMeal(
                        name: nameController.text,
                        calories: (baseCals * factor).round(),
                        protein: (basePro * factor).round(),
                        carbs: (baseCarb * factor).round(),
                        fats: (baseFat * factor).round(),
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Save Log", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // --- FUNCTION: AI GENERATION INJECTION ---
  void _generateAIDietPlan() {
    // In a future production build, connect this to your network layer parsing response body blocks
    setState(() {
      aiRecommendations["Breakfast"] = "3 Egg Whites + 50g Oats with Berries";
      aiRecommendations["Lunch"] = "150g Grilled Breast Chicken + 1 Cup Basmati Rice";
      aiRecommendations["Dinner"] = "200g Salmon Fillet + Grilled Asparagus & Sweet Potato";
      aiRecommendations["Snacks"] = "1 Scoop Whey Protein + 1 Medium Apple";

      // Customize target bounds conditionally based on selection criteria rules
      targetCalories = 2200;
      targetProtein = 160;
      targetCarbs = 230;
      targetFats = 70;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✨ AI Diet Chart successfully loaded into recommendations!"),
        backgroundColor: Color(0xFF111111),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD4FF00);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP TITLE BAR
              const Row(
                children: [
                  Text(
                    "NUTRITION LOG",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today_outlined, color: Colors.white70, size: 22),
                ],
              ),

              const SizedBox(height: 24),

              /// PERFORMANCE CALORIE & MACRO TRACKER CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CALORIES REMAINING",
                      style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "$caloriesRemaining", style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                          TextSpan(text: " / $targetCalories kcal", style: const TextStyle(color: Colors.white30, fontSize: 18)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white10, height: 1),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMacroIndicator("PROTEIN", "$totalProteinEaten\u200bg / ${targetProtein}g", totalProteinEaten / targetProtein, Colors.orangeAccent),
                        _buildMacroIndicator("CARBS", "$totalCarbsEaten\u200bg / ${targetCarbs}g", totalCarbsEaten / targetCarbs, Colors.cyanAccent),
                        _buildMacroIndicator("FATS", "$totalFatsEaten\u200bg / ${targetFats}g", totalFatsEaten / targetFats, neon),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// AI DIET GENERATOR CARD
              InkWell(
                onTap: _generateAIDietPlan,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: neon.withOpacity(0.3), width: 1.5),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "🪄 AI Smart Meal Planner",
                              style: TextStyle(color: neon, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Generate AI Diet Plan",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Syncs your BMI to formulate exact daily custom diets.",
                              style: TextStyle(color: Colors.white60, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.auto_awesome, color: neon, size: 22),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// MEAL TRACKING INTERACTIVE ROWS
              const Text(
                "MEALS TODAY",
                style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 14),

              _buildInteractiveMealCard("Breakfast", Icons.wb_twilight_rounded),
              _buildInteractiveMealCard("Lunch", Icons.wb_sunny_rounded),
              _buildInteractiveMealCard("Dinner", Icons.dark_mode_rounded),
              _buildInteractiveMealCard("Snacks", Icons.apple_rounded),
            ],
          ),
        ),
      ),
    );
  }

  /// Interactive Builder for Component Selection Nodes
  Widget _buildInteractiveMealCard(String mealType, IconData icon) {
    final meal = loggedMeals[mealType];
    final aiRec = aiRecommendations[mealType];
    bool hasLogged = meal != null && meal.name.isNotEmpty;
    bool hasAiPlan = aiRec != "Pending setup...";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: hasLogged ? const Color(0xFFD4FF00).withOpacity(0.2) : Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: hasLogged ? const Color(0xFFD4FF00) : Colors.white24, size: 26),
        title: Text(
          mealType,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hasLogged ? "Logged: ${meal.name}" : "No food logged yet",
                style: TextStyle(color: hasLogged ? Colors.white70 : Colors.white30, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                hasAiPlan ? "📋 AI Target: $aiRec" : "💡 Tap AI setup above for suggestions",
                style: TextStyle(color: hasAiPlan ? const Color(0xFFD4FF00).withOpacity(0.7) : Colors.white24, fontSize: 12),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              hasLogged ? "${meal.calories} kcal" : "— kcal",
              style: TextStyle(color: hasLogged ? Colors.white : Colors.white24, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Icon(Icons.add_circle_outline, color: hasLogged ? const Color(0xFFD4FF00) : Colors.white30, size: 18),
          ],
        ),
        onTap: () => _openLogMealBottomSheet(mealType),
      ),
    );
  }

  /// Reusable Progress Bar Metrics Formatter
  Widget _buildMacroIndicator(String title, String values, double progress, Color color) {
    double checkedProgress = progress.isNaN || progress.isInfinite ? 0.0 : progress;
    if (checkedProgress > 1.0) checkedProgress = 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(values, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        SizedBox(
          width: 90,
          child: LinearProgressIndicator(
            value: checkedProgress,
            backgroundColor: Colors.white10,
            color: color,
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        )
      ],
    );
  }
}

// --- CORE DATA ARTIFACT CONTAINER ---
class LoggedMeal {
  final String name;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  LoggedMeal({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}