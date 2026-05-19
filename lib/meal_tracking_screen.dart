// meal_tracking_screen.dart

import 'package:flutter/material.dart';

class MealTrackingScreen extends StatelessWidget {
  const MealTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD4FF00);

    return Scaffold(
      backgroundColor: Colors.black,

      /// NEW NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF111111),
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: neon,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.featured_video_sharp),
            label: "Features",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: "Library",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Activity",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "PROFILE",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP BAR
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: neon.withOpacity(0.5)),
                      image: const DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Text(
                    "PERFORMANCE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),

              const SizedBox(height: 34),

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DAILY FUELING",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Nutrition\nInsights",
                        style: TextStyle(
                          fontSize: 42,
                          height: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: neon,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Add\nMeal",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// CALORIES CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CALORIES REMAINING",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "1,480",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " / 2,800 kcal",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              /// HYDRATION + GOAL
              Row(
                children: [
                  Expanded(
                    child: infoCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                            size: 42,
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            "HYDRATION",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "2.4L",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Goal: 3.5L",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: infoCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: CircularProgressIndicator(
                                    value: 0.75,
                                    strokeWidth: 10,
                                    backgroundColor: Colors.white10,
                                    valueColor:
                                    const AlwaysStoppedAnimation(neon),
                                  ),
                                ),

                                const Text(
                                  "75%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            "DAILY GOAL",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// MACRONUTRIENTS
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Macronutrients",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 28),

                    macroRow(
                      "PROTEIN",
                      "142g / 180g",
                      0.8,
                      neon,
                    ),

                    const SizedBox(height: 18),

                    macroRow(
                      "CARBS",
                      "210g / 320g",
                      0.7,
                      Colors.cyanAccent,
                    ),

                    const SizedBox(height: 18),

                    macroRow(
                      "FATS",
                      "52g / 75g",
                      0.75,
                      Colors.white70,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// DAILY MEALS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Daily Meals",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "VIEW ALL",
                    style: TextStyle(
                      color: neon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              mealCard(
                time: "08:30 AM",
                title: "Power Omelette",
                subtitle: "420 kcal • 32g Protein",
              ),

              const SizedBox(height: 18),

              mealCard(
                time: "01:15 PM",
                title: "Quinoa Fusion Bowl",
                subtitle: "610 kcal • 45g Protein",
              ),

              const SizedBox(height: 18),

              mealCard(
                time: "04:00 PM",
                title: "Whey Isolate & Nuts",
                subtitle: "280 kcal • 24g Protein",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget infoCard({required Widget child}) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }

  static Widget macroRow(
      String title,
      String value,
      double progress,
      Color color,
      ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 14,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  static Widget mealCard({
    required String time,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade800,
            ),
            child: const Icon(
              Icons.restaurant,
              color: Colors.white,
              size: 40,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white70,
          )
        ],
      ),
    );
  }
}