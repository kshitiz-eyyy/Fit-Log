import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(Icons.fitness_center, "Train"),
            _selectedNavItem(Icons.restaurant, "Fuel"),
            _navItem(Icons.water_drop_outlined, "Cycle"),
            _navItem(Icons.bar_chart, "Insights"),
            _navItem(Icons.support_agent, "Support"),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: const AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "PERFORMANCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// CALORIES CARD
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "DAILY CALORIES",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "2,480",
                            style: TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: " / 2,800 kcal",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.89,
                        minHeight: 10,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFFC6FF00),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// PROTEIN + CARBS
              Row(
                children: [
                  Expanded(
                    child: _miniCard("PROTEIN", "185", "G"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _miniCard("CARBS", "210", "G"),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// HYDRATION
              _glassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Hydration",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "2.8",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " / 3.5 L",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "85% of daily goal",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: List.generate(
                        8,
                            (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: 60,
                            decoration: BoxDecoration(
                              color: index < 6
                                  ? const Color(0xFFC6FF00)
                                  : Colors.white10,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "MICRONUTRIENT BREAKDOWN",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _vitaminCard(
                      "VITAMINS",
                      "Vitamin D",
                      1.0,
                      "120%",
                      "Vitamin C",
                      0.45,
                      "45%",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _vitaminCard(
                      "MINERALS",
                      "Magnesium",
                      0.92,
                      "92%",
                      "Iron",
                      0.68,
                      "68%",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// HEATMAP
              _glassCard(
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "CONSISTENCY HEATMAP",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Oct 2023",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: List.generate(
                        30,
                            (index) => Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: [
                              Colors.white10,
                              Color(0xFF556B00),
                              Color(0xFF8FB800),
                              Color(0xFFC6FF00),
                            ][index % 4],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }

  Widget _miniCard(String title, String value, String unit) {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vitaminCard(
      String title,
      String item1,
      double p1,
      String v1,
      String item2,
      double p2,
      String v2,
      ) {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(item1,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18)),
          LinearProgressIndicator(
            value: p1,
            color: const Color(0xFFC6FF00),
            backgroundColor: Colors.white10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(v1,
                style: const TextStyle(color: Colors.white70)),
          ),
          const SizedBox(height: 15),
          Text(item2,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18)),
          LinearProgressIndicator(
            value: p2,
            color: const Color(0xFFC6FF00),
            backgroundColor: Colors.white10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(v2,
                style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white54),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _selectedNavItem(IconData icon, String text) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFFC6FF00),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}