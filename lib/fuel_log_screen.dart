import 'package:flutter/material.dart';
import 'dart:math' as math;

class FuelLogScreen extends StatelessWidget {
  const FuelLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C0C0C);
    const accentColor = Color(0xFFD4FF00);
    const cardColor = Color(0xFF141414);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E8E);
    const orangeColor = Color(0xFFFF5A1F);
    const cyanColor = Color(0xFF00E5FF);

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
                          children: const [
                            Text(
                              '+420',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 8),
                            Padding(
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
                              'SURPLUS',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.trending_up, color: accentColor, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  '12%',
                                  style: TextStyle(
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
                            value: '2,840',
                            progress: 0.85,
                            progressColor: accentColor,
                            subLeft: '85% OF TARGET',
                            subRight: '3,200 GOAL',
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildEnergyStat(
                            label: 'INTAKE',
                            value: '2,420',
                            valueColor: orangeColor,
                            progress: 0.72,
                            progressColor: orangeColor,
                            subLeft: '72% OF LIMIT',
                            subRight: '3,000 LIMIT',
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
                            amount: '160g',
                            target: '200g',
                            percent: 80,
                            color: accentColor,
                            cardColor: cardColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMacroCard(
                            label: 'CARBS',
                            amount: '220g',
                            target: '400g',
                            percent: 55,
                            color: textColor,
                            cardColor: cardColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMacroCard(
                            label: 'FATS',
                            amount: '54g',
                            target: '180g',
                            percent: 30,
                            color: cyanColor,
                            cardColor: cardColor,
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
                      calories: '450',
                      cardColor: cardColor,
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Lunch',
                      subtitle: 'Grilled Chicken & Quinoa',
                      calories: '720',
                      cardColor: cardColor,
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 12),
                    // Dinner (Empty State)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: accentColor.withOpacity(0.5)),
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
                    const SizedBox(height: 12),
                    _buildFuelItem(
                      title: 'Snacks',
                      subtitle: 'Whey Isolate & Almonds',
                      calories: '320',
                      cardColor: cardColor,
                      accentColor: accentColor,
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
        shape: const CircleShape(),
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
          style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 10, fontWeight: FontWeight.bold),
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
            Text(subLeft, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 8, fontWeight: FontWeight.bold)),
            Text(subRight, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 8, fontWeight: FontWeight.bold)),
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
    required Color cardColor,
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
                Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 4,
                      color: const Color(0xFF2C2C2C),
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
            style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 9, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          Text(
            'of $target',
            style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildFuelItem({
    required String title,
    required String subtitle,
    required String calories,
    required Color cardColor,
    required Color accentColor,
  }) {
    return Container(
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
              image: const DecorationImage(
                image: NetworkImage('https://placeholder.com/48'), // Placeholder
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
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
                  style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                calories,
                style: TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'KCAL',
                style: TextStyle(color: Color(0xFF8E8E93), fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const Icon(Icons.chevron_right, color: Color(0xFF333333), size: 18),
        ],
      ),
    );
  }
}
