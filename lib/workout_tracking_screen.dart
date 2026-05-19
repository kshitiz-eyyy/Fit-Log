import 'package:flutter/material.dart';

class WorkoutTrackingScreen extends StatelessWidget {
  const WorkoutTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD4FF00);

    return Scaffold(
      backgroundColor: Colors.black,

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BottomItem(Icons.fitness_center, "Train", true),
            BottomItem(Icons.restaurant, "Fuel", false),
            BottomItem(Icons.water_drop, "Cycle", false),
            BottomItem(Icons.grid_view, "Insights", false),
            BottomItem(Icons.support_agent, "Support", false),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP BAR
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/300",
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

                  Icon(
                    Icons.notifications_none,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// MAIN CARD
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white10),
                  boxShadow: [
                    BoxShadow(
                      color: neon.withOpacity(0.1),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: CircularProgressIndicator(
                              value: 0.75,
                              strokeWidth: 14,
                              backgroundColor: Colors.white10,
                              valueColor:
                              const AlwaysStoppedAnimation(neon),
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "75%",
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "DAILY GOAL",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text(
                              "1,240",
                              style: TextStyle(
                                color: neon,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "STEPS",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),

                        const SizedBox(width: 50),

                        Column(
                          children: const [
                            Text(
                              "45",
                              style: TextStyle(
                                color: neon,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "MINS",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 22),

              /// STATS
              Row(
                children: [
                  Expanded(
                    child: statCard(
                      icon: Icons.favorite_border,
                      title: "BPM",
                      value: "142",
                      subtitle: "PEAK LEVEL",
                      neon: neon,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: statCard(
                      icon: Icons.local_fire_department_outlined,
                      title: "KCAL",
                      value: "842",
                      subtitle: "BURNED",
                      neon: neon,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              /// STREAK CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: neon,
                      ),
                      child: const Icon(
                        Icons.bolt,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(width: 18),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "12 DAY STREAK",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "PERSONAL RECORD",
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              /// INTENSITY MAP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Intensity Map",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Last 30 days activity volume",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "VIEW ALL",
                    style: TextStyle(
                      color: neon,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 28,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final colors = [
                          Colors.green.shade900,
                          Colors.lime.shade700,
                          neon,
                          Colors.lime.shade900,
                        ];

                        return Container(
                          decoration: BoxDecoration(
                            color: colors[index % 4],
                            borderRadius: BorderRadius.circular(6),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "LESS",
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            dot(Colors.green.shade900),
                            dot(Colors.lime.shade900),
                            dot(Colors.lime.shade700),
                            dot(neon),
                          ],
                        ),
                        const Text(
                          "MORE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// WORKOUT CARD
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Morning\nHIIT",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "35 minutes\nremaining",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: neon,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "RESUME",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static Widget dot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  static Widget statCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color neon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: neon),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const SizedBox(height: 18),

          Text(
            value,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: TextStyle(
              color: neon,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const BottomItem(
      this.icon,
      this.label,
      this.active, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD4FF00);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: active ? neon : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: active ? Colors.black : Colors.white70,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: TextStyle(
            color: active ? neon : Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}