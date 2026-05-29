import 'package:flutter/material.dart';
import 'bmi_calculator_screen.dart';
import 'favourite_exercise.dart';

class AppColors {
  static const Color background = Colors.black; //
  static const Color surfaceCard = Color(0xFF0E0E0E);
  static const Color neonAccent = Color(0xFFCCFF00);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
}

class FeatureItem {
  final String title;
  final String description;
  final IconData icon;

  FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class FeaturesScreen extends StatelessWidget {
  FeaturesScreen({super.key});

  final List<FeatureItem> features = [
    FeatureItem(
      title: 'Favourite Exercises',
      description: 'Quickly access and manage your curated workout moves.',
      icon: Icons.favorite,
    ),
    FeatureItem(
      title: 'Contact Trainer',
      description: 'Get professional guidance and 1-on-1 coaching.',
      icon: Icons.fitness_center,
    ),
    FeatureItem(
      title: 'Contact Dietitian',
      description: 'Customized meal plans tailored to your fitness goals.',
      icon: Icons.restaurant,
    ),
    FeatureItem(
      title: 'BMI Calculator',
      description: 'Track your body mass index progress effortlessly.',
      icon: Icons.calculate,
    ),
    FeatureItem(
      title: 'Calorie Tracker',
      description: 'Log daily meals and maintain your caloric deficit/surplus.',
      icon: Icons.local_fire_department,
    ),
    FeatureItem(
      title: 'Sleep Tracking',
      description: 'Monitor your recovery and sleep cycles for peak performance.',
      icon: Icons.bedtime,
    ),
    FeatureItem(
      title: 'Workout Analytics',
      description: 'Deep dive into your performance metrics over time.',
      icon: Icons.analytics,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.neonAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'F',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'FITLOG',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FEATURES',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select a tool to enhance your training regimen.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  itemCount: features.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final item = features[index];
                    return _buildFeatureCard(item, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(FeatureItem item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neonAccent.withValues(alpha: 0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonAccent.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (item.title == 'Favourite Exercises') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteExerciseScreen(),
                ),
              );
            } else if (item.title == 'BMI Calculator') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BMICalculatorScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} screen coming soon!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: AppColors.neonAccent,
                    size: 28,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}