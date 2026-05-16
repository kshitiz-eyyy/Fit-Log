import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.black;
    const accentColor = Color(0xFFD0FD3E);
    const cardColor = Color(0xFF1C1C1E);
    const innerCardColor = Color(0xFF0F0F0F);
    const textColor = Colors.white;
    const secondaryTextColor = Color(0xFF8E8E93);
    const infoColor = Color(0xFFFF5A1F);

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
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, color: accentColor, size: 24),
                  ),
                  const Text(
                    'FITLOG',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.notifications_none, color: textColor, size: 24),
                      const SizedBox(width: 16),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: accentColor, width: 1),
                        ),
                        child: const Icon(Icons.person_outline, color: Colors.grey, size: 20),
                      ),
                    ],
                  ),
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
                      'PERSONAL\nDETAILS',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Optimize your technical profile for precision tracking.',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Identity Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person_outline, color: accentColor, size: 16),
                              SizedBox(width: 8),
                              Text(
                                'IDENTITY',
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInputField('FULL NAME', 'ALEX RIVERA'),
                          const SizedBox(height: 12),
                          _buildInputField('PERFORMANCE EMAIL', 'alex.rivera@forge.pro'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Metrics Sections
                    _buildMetricStepper(
                      icon: Icons.height,
                      label: 'HEIGHT',
                      unit: 'CM',
                      value: '182',
                      accentColor: accentColor,
                      cardColor: cardColor,
                      innerColor: innerCardColor,
                    ),
                    const SizedBox(height: 16),
                    _buildMetricStepper(
                      icon: Icons.fitness_center,
                      label: 'WEIGHT',
                      unit: 'KG',
                      value: '84.5',
                      accentColor: accentColor,
                      cardColor: cardColor,
                      innerColor: innerCardColor,
                    ),
                    const SizedBox(height: 16),
                    _buildMetricStepper(
                      icon: Icons.pie_chart_outline,
                      label: 'BODY COMPOSITION',
                      unit: 'BF%',
                      value: '12.4',
                      accentColor: accentColor,
                      cardColor: cardColor,
                      innerColor: innerCardColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Info Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.info_outline, color: infoColor, size: 20),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Update these metrics regularly for the most accurate metabolic and recovery calculations. Forge uses these to calibrate your intensity zones.',
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Bottom Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'SAVE CHANGES',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF333333)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricStepper({
    required IconData icon,
    required String label,
    required String unit,
    required String value,
    required Color accentColor,
    required Color cardColor,
    required Color innerColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: accentColor, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                unit,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: innerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Column(
                    children: const [
                      Icon(Icons.keyboard_arrow_up, color: Color(0xFF333333), size: 24),
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFF333333), size: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
