import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealTrackingScreen extends StatefulWidget {
  const MealTrackingScreen({super.key});

  @override
  State<MealTrackingScreen> createState() => _MealTrackingScreenState();
}

class _MealTrackingScreenState extends State<MealTrackingScreen> {
  Color color = Color(0xFFCCFF00);

  // --- LOCAL BMI RETRIEVED VARIABLES ---
  double savedWeight = 70.0; // Default fallback if BMI screen hasn't run yet
  double savedHeight = 175.0; // Default fallback

  @override
  void initState() {
    super.initState();
    _loadBMIData(); // Automatically pull data when screen opens
  }

  // Pure connection method: Pulls weight & height saved by your BMI section
  Future<void> _loadBMIData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Looks for keys "user_weight" and "user_height" saved by your BMI logic
      savedWeight = prefs.getDouble('user_weight') ?? 70.0;
      savedHeight = prefs.getDouble('user_height') ?? 175.0;
    });
  }

  // --- STATE VARIABLES FOR LOGGED MEALS ---
  Map<String, LoggedMeal> loggedMeals = {
    "Breakfast": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Lunch": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Dinner": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
    "Snacks": LoggedMeal(name: "", calories: 0, protein: 0, carbs: 0, fats: 0),
  };

  Map<String, String> aiRecommendations = {
    "Breakfast": "Pending setup...",
    "Lunch": "Pending setup...",
    "Dinner": "Pending setup...",
    "Snacks": "Pending setup...",
  };

  int targetCalories = 2500;
  int targetProtein = 150;
  int targetCarbs = 250;
  int targetFats = 70;

  // --- GETTERS FOR TOTALS ---
  int get totalCaloriesEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.calories);
  int get totalProteinEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.protein);
  int get totalCarbsEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.carbs);
  int get totalFatsEaten => loggedMeals.values.fold(0, (sum, item) => sum + item.fats);

  int get caloriesRemaining => targetCalories - totalCaloriesEaten;

  // --- DIALOG ENGINE: CONVERTS PROFILE DATA TO REAL DIET CHARTS ---
  void _openAIDietSetupDialog() {
    String selectedGoal = 'Weight Loss';
    String selectedActivity = 'Moderately Active';
    final TextEditingController ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.white10),
          ),
          title: const Row(
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFFCCFF00)),
              SizedBox(width: 10),
              Text("AI Diet Setup", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Visual Confirmation indicating connection is active
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.link, color: Color(0xFFCCFF00), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Connected to BMI: ${savedWeight.toStringAsFixed(1)}kg, ${savedHeight.toStringAsFixed(0)}cm",
                          style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Text("ENTER YOUR AGE", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "e.g. 24",
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),

                const Text("SELECT FITNESS GOAL", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedGoal,
                  dropdownColor: const Color(0xFF151515),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  items: ['Weight Loss', 'Muscle Gain', 'Maintenance'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (newValue) => selectedGoal = newValue!,
                ),
                const SizedBox(height: 20),

                const Text("ACTIVITY LEVEL", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedActivity,
                  dropdownColor: const Color(0xFF151515),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  items: ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (newValue) => selectedActivity = newValue!,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCCFF00),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                int parsedAge = int.tryParse(ageController.text) ?? 25;

                // 1. MIFFLIN-ST JEOR FORMULA (Calculates real algorithmic baseline metabolic outputs)
                double bmr = (10 * savedWeight) + (6.25 * savedHeight) - (5 * parsedAge) + 5;

                // 2. APPLY ACTIVITY MULTIPLIERS
                double activityMultiplier = 1.2;
                if (selectedActivity == 'Lightly Active') activityMultiplier = 1.375;
                if (selectedActivity == 'Moderately Active') activityMultiplier = 1.55;
                if (selectedActivity == 'Very Active') activityMultiplier = 1.725;
                double tdee = bmr * activityMultiplier;

                // 3. GENERATE CUSTOM DIET CHART MATRIX VALUES BASED ON USER GOAL
                setState(() {
                  if (selectedGoal == 'Weight Loss') {
                    targetCalories = (tdee - 500).round();
                    targetProtein = (savedWeight * 2.0).round(); // High protein for fat loss preservation
                    targetFats = ((targetCalories * 0.25) / 9).round();
                    targetCarbs = ((targetCalories - (targetProtein * 4) - (targetFats * 9)) / 4).round();

                    aiRecommendations["Breakfast"] = "🍳 3 Egg Whites Scramble + 40g Oats (${(targetCalories * 0.25).round()} kcal)";
                    aiRecommendations["Lunch"] = "🥗 150g Grilled Chicken Breast + Broccoli (${(targetCalories * 0.35).round()} kcal)";
                    aiRecommendations["Dinner"] = "🐟 150g Baked Salmon + Asparagus Spears (${(targetCalories * 0.30).round()} kcal)";
                    aiRecommendations["Snacks"] = "🥛 1 Scoop Whey Protein + 1 Apple (${(targetCalories * 0.10).round()} kcal)";

                  } else if (selectedGoal == 'Muscle Gain') {
                    targetCalories = (tdee + 400).round();
                    targetProtein = (savedWeight * 2.2).round(); // Surplus scaling macros
                    targetFats = ((targetCalories * 0.25) / 9).round();
                    targetCarbs = ((targetCalories - (targetProtein * 4) - (targetFats * 9)) / 4).round();

                    aiRecommendations["Breakfast"] = "🥞 4 Whole Eggs + 100g Oats + 1 Banana (${(targetCalories * 0.25).round()} kcal)";
                    aiRecommendations["Lunch"] = "🥩 200g Lean Ground Beef + 1.5 Cups White Rice (${(targetCalories * 0.35).round()} kcal)";
                    aiRecommendations["Dinner"] = "🍗 200g Chicken Thighs + Large Sweet Potato (${(targetCalories * 0.30).round()} kcal)";
                    aiRecommendations["Snacks"] = "🥜 Mass Gainer Shake + 2 Tbsp Peanut Butter (${(targetCalories * 0.10).round()} kcal)";

                  } else {
                    targetCalories = tdee.round();
                    targetProtein = (savedWeight * 1.8).round();
                    targetFats = ((targetCalories * 0.25) / 9).round();
                    targetCarbs = ((targetCalories - (targetProtein * 4) - (targetFats * 9)) / 4).round();

                    aiRecommendations["Breakfast"] = "🥪 3 Scrambled Eggs + 2 Slices Whole Wheat Toast (${(targetCalories * 0.25).round()} kcal)";
                    aiRecommendations["Lunch"] = "🌯 Large Turkey & Avocado Wrap + Mixed Greens (${(targetCalories * 0.35).round()} kcal)";
                    aiRecommendations["Dinner"] = "🐠 180g White Fish Fillet + Quinoa Bowl (${(targetCalories * 0.30).round()} kcal)";
                    aiRecommendations["Snacks"] = "🍯 200g Greek Yogurt + Handful of Almonds (${(targetCalories * 0.10).round()} kcal)";
                  }
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("✨ Generated full macro diet chart for $selectedGoal!"),
                    backgroundColor: const Color(0xFF111111),
                  ),
                );
              },
              child: const Text("Generate", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // --- FUNCTION: LOG A MEAL MANUAL FLOW ---
  void _openLogMealBottomSheet(String mealType) {
    final nameController = TextEditingController(text: loggedMeals[mealType]?.name);
    String selectedPortion = "1 Serving";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
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
              Text("Log $mealType", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              if (aiRecommendations[mealType] != "Pending setup...")
                Text(
                  "💡 AI Suggestion: ${aiRecommendations[mealType]}",
                  style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 13, fontWeight: FontWeight.w500),
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
                    backgroundColor: Color(0xFFCCFF00),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) return;

                    double factor = 1.0;
                    if (selectedPortion == "0.5 Serving") factor = 0.5;
                    if (selectedPortion == "1.5 Servings") factor = 1.5;
                    if (selectedPortion == "2 Servings") factor = 2.0;

                    // Calculates target distributions safely based on your dynamically created targets
                    int baseCals = (targetCalories * (mealType == "Breakfast" ? 0.25 : mealType == "Lunch" ? 0.35 : mealType == "Dinner" ? 0.30 : 0.10)).round();
                    int basePro = (targetProtein * (mealType == "Breakfast" ? 0.25 : mealType == "Lunch" ? 0.35 : mealType == "Dinner" ? 0.30 : 0.10)).round();
                    int baseCarb = (targetCarbs * (mealType == "Breakfast" ? 0.25 : mealType == "Lunch" ? 0.35 : mealType == "Dinner" ? 0.30 : 0.10)).round();
                    int baseFat = (targetFats * (mealType == "Breakfast" ? 0.25 : mealType == "Lunch" ? 0.35 : mealType == "Dinner" ? 0.30 : 0.10)).round();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP BAR
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 48.0),
                        child: Text(
                          "NUTRITION LOG",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFCCFF00), letterSpacing: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// CALORIE & MACRO CARD
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
                        _buildMacroIndicator("FATS", "$totalFatsEaten\u200bg / ${targetFats}g", totalFatsEaten / targetFats, Color(0xFFCCFF00)),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// AI DIET GENERATOR CARD
              InkWell(
                onTap: _openAIDietSetupDialog,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFFCCFF00).withOpacity(0.3), width: 1.5),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "🪄 AI Smart Meal Planner",
                              style: TextStyle(color: Color(0xFFCCFF00), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
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
                      Icon(Icons.auto_awesome, color: Color(0xFFCCFF00), size: 22),
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
        border: Border.all(color: hasLogged ? Color(0xFFCCFF00).withOpacity(0.2) : Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: hasLogged ? Color(0xFFCCFF00) : Colors.white24, size: 26),
        title: Text(mealType, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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
                style: TextStyle(color: hasAiPlan ? Color(0xFFCCFF00).withOpacity(0.7) : Colors.white24, fontSize: 12),
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
            Icon(Icons.add_circle_outline, color: hasLogged ? Color(0xFFCCFF00) : Colors.white30, size: 18),
          ],
        ),
        onTap: () => _openLogMealBottomSheet(mealType),
      ),
    );
  }

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