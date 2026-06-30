import 'package:fitlog/theme/app_theme.dart';
import 'package:fitlog/view/performance_screen.dart';
import 'package:fitlog/view/track_membershiscreen.dart';
import 'package:flutter/material.dart';
import 'bmi_calculator_screen.dart';

import 'contact_dietitan_screen.dart';
import 'contact_trainer_screen.dart';

class FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  final String? imagePath;

  FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    this.imagePath,
  });
}

class FeaturesScreen extends StatelessWidget {
  FeaturesScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  final List<FeatureItem> features = [
    FeatureItem(
      title: 'Contact Trainer',
      description: 'Get professional guidance and 1-on-1 coaching.',
      icon: Icons.fitness_center,
      imagePath: 'assets/images/trainer.png',
    ),
    FeatureItem(
      title: 'Contact Dietitian',
      description: 'Customized meal plans tailored to your fitness goals.',
      icon: Icons.restaurant,
      imagePath: 'assets/images/diet.png',
    ),
    FeatureItem(
      title: 'BMI Calculator',
      description: 'Track your body mass index progress effortlessly.',
      icon: Icons.calculate,
      imagePath: 'assets/images/bmi.png',
    ),
    FeatureItem(
      title: 'Calorie Tracker',
      description: 'Log daily meals and maintain your caloric deficit/surplus.',
      icon: Icons.local_fire_department,
    ),
    FeatureItem(
      title: 'Sleep Tracking',
      description:
          'Monitor your recovery and sleep cycles for peak performance.',
      icon: Icons.bedtime,
    ),
    FeatureItem(
      title: 'Performance',
      description: 'Deep dive into your performance metrics over time.',
      icon: Icons.calendar_month,
      imagePath: 'assets/images/calender.png',
    ),
    FeatureItem(
      title: 'Membership',
      description: 'Track your subscription cycle and remaining days.',
      icon: Icons.card_membership,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              return;
            }
            onBack?.call();
          },
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colors.neonAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'F',
                style: TextStyle(
                  color: colors.background,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'FITLOG',
              style: TextStyle(
                color: colors.textPrimary,
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
              Text(
                'FEATURES',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select a tool to enhance your training regimen.',
                style: TextStyle(color: colors.textSecondary, fontSize: 14),
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
    final colors = AppTheme.colorsOf(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border, width: 1),
        image: item.imagePath != null
            ? DecorationImage(
                image: AssetImage(item.imagePath!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.35),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (item.title == 'BMI Calculator') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BMICalculatorScreen(),
                ),
              );
            } else if (item.title == 'Contact Trainer') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactTrainerScreen(),
                ),
              );
            } else if (item.title == 'Contact Dietitian') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactDietitianScreen(),
                ),
              );
            } else if (item.title == 'Performance') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PerformanceScreen(),
                ),
              );
            } else if (item.title == 'Membership') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrackMembershipScreen(),
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
                    color: colors.background.withValues(
                      alpha: item.imagePath != null ? 0.8 : 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.icon, color: colors.neonAccent, size: 28),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: colors.textSecondary,
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
