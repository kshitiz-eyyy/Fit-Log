import 'package:flutter/material.dart';

class MealTrackingScreen extends StatelessWidget {
  MealTrackingScreen({super.key});

  final Color neon = const Color(0xFFD4FF00);

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
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: neon,
                        width: 1.5,
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Text(
                    "PERFORMANCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
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
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        "Nutrition\nInsights",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      color: neon,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: neon.withValues(alpha: 0.45),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [

                        Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Add\nMeal",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// CALORIES CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF171717),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "CALORIES REMAINING",
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 10),

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
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          buildBar(40, Colors.lime.shade900),
                          const SizedBox(width: 4),

                          buildBar(60, Colors.lime.shade800),
                          const SizedBox(width: 4),

                          buildBar(30, Colors.lime.shade900),
                          const SizedBox(width: 4),

                          buildBar(85, neon),

                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              height: 1,
                              color: Colors.lime.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// HYDRATION + GOAL
              Row(
                children: [

                  Expanded(
                    child: buildSmallCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                            size: 50,
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            "HYDRATION",
                            style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "2.4L",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Goal: 3.5L",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: buildSmallCard(
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
                                    AlwaysStoppedAnimation(neon),
                                  ),
                                ),

                                const Text(
                                  "75%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

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

              const SizedBox(height: 28),

              /// MACROS
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF171717),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Macronutrients",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 28),

                    buildMacro(
                      "PROTEIN",
                      "142g / 180g",
                      0.8,
                      neon,
                    ),

                    const SizedBox(height: 18),

                    buildMacro(
                      "CARBS",
                      "210g / 320g",
                      0.7,
                      Colors.cyanAccent,
                    ),

                    const SizedBox(height: 18),

                    buildMacro(
                      "FATS",
                      "52g / 75g",
                      0.75,
                      Colors.white70,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// DAILY MEALS TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "Daily Meals",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "VIEW ALL",
                    style: TextStyle(
                      color: neon,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildMealCard(
                image:
                "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
                time: "08:30 AM",
                title: "Power Omelette",
                subtitle: "420 kcal • 32g Protein",
              ),

              const SizedBox(height: 18),

              buildMealCard(
                image:
                "https://images.unsplash.com/photo-1512621776951-a57141f2eefd",
                time: "01:15 PM",
                title: "Quinoa Fusion Bowl",
                subtitle: "610 kcal • 45g Protein",
              ),

              const SizedBox(height: 18),

              buildMealCard(
                image:
                "https://images.unsplash.com/photo-1579722821273-0f6c7d44362f",
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

  Widget buildBar(double height, Color color) {
    return Container(
      width: 45,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget buildSmallCard({required Widget child}) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }

  Widget buildMacro(
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  Widget buildMealCard({
    required String image,
    required String time,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [

          Container(
            height: 86,
            width: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
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
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.white70,
            size: 30,
          ),
        ],
      ),
    );
  }
}