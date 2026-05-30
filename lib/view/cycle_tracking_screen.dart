import 'package:flutter/material.dart';

class CycleTrackingScreen extends StatefulWidget {
  const CycleTrackingScreen({super.key});

  @override
  State<CycleTrackingScreen> createState() =>
      _CycleTrackingScreenState();
}

class _CycleTrackingScreenState
    extends State<CycleTrackingScreen> {
  static const Color neon = Color(0xFFD4FF00);

  String selectedLog = "Mood";
  String selectedMessage =
      "You are feeling positive and balanced today.";

  void updateLog(String type) {
    setState(() {
      selectedLog = type;

      switch (type) {
        case "Mood":
          selectedMessage =
          "You are feeling positive and balanced today.";
          break;

        case "Flow":
          selectedMessage =
          "Flow level is moderate and cycle is progressing normally.";
          break;

        case "Sleep":
          selectedMessage =
          "Sleep quality was strong. Recovery levels are good.";
          break;

        case "Energy":
          selectedMessage =
          "Energy levels are peaking. Perfect time for intense training.";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF111111),
        selectedItemColor: neon,
        unselectedItemColor: Colors.white54,
        currentIndex: 2,
        elevation: 0,
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
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: neon.withValues(alpha: 0.4),
                      ),
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

              const SizedBox(height: 28),

              /// STATUS CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.03),
                      neon.withValues(alpha: 0.06),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "CURRENT STATUS",
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Day 14",
                      style: TextStyle(
                        color: neon,
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [

                        const Expanded(
                          child: Text(
                            "Predicted Ovulation: Tomorrow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            buildDot(neon),
                            buildDot(
                              neon.withValues(alpha: 0.6),
                            ),
                            buildDot(
                              neon.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              /// SMALL INFO CARDS
              Row(
                children: [

                  Expanded(
                    child: buildInfoCard(
                      title: "CYCLE LENGTH",
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "28",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " days",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Container(
                      height: 140,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151515),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: const [

                          Text(
                            "PHASE",
                            style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(height: 12),

                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Follicular",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              /// TITLE ROW
              Row(
                children: [

                  const Expanded(
                    child: Text(
                      "Cycle Overview",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(
                          Icons.chevron_left,
                          color: neon,
                          size: 18,
                        ),

                        SizedBox(width: 4),

                        Text(
                          "October",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(width: 4),

                        Icon(
                          Icons.chevron_right,
                          color: neon,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// CALENDAR CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        DayLabel("M"),
                        DayLabel("T"),
                        DayLabel("W"),
                        DayLabel("T"),
                        DayLabel("F"),
                        DayLabel("S"),
                        DayLabel("S"),
                      ],
                    ),

                    const SizedBox(height: 24),

                    GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1,
                      children: List.generate(21, (index) {
                        final day = index + 1;

                        bool period =
                            day >= 5 && day <= 8;

                        bool fertile =
                            day == 15 || day == 16;

                        bool selected = day == 14;

                        return CalendarDay(
                          text: day.toString(),
                          period: period,
                          fertile: fertile,
                          selected: selected,
                        );
                      }),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [

                        buildLegend(neon),

                        const SizedBox(width: 8),

                        const Text(
                          "Period",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 28),

                        buildLegend(Colors.cyan),

                        const SizedBox(width: 8),

                        const Text(
                          "Fertile",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// TODAY LOG
              const Text(
                "Today's Log",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: () => updateLog("Mood"),
                    child: LogItem(
                      icon: Icons.sentiment_satisfied_alt,
                      label: "Mood",
                      active: selectedLog == "Mood",
                    ),
                  ),

                  GestureDetector(
                    onTap: () => updateLog("Flow"),
                    child: LogItem(
                      icon: Icons.water_drop_outlined,
                      label: "Flow",
                      active: selectedLog == "Flow",
                    ),
                  ),

                  GestureDetector(
                    onTap: () => updateLog("Sleep"),
                    child: LogItem(
                      icon: Icons.bed_outlined,
                      label: "Sleep",
                      active: selectedLog == "Sleep",
                    ),
                  ),

                  GestureDetector(
                    onTap: () => updateLog("Energy"),
                    child: LogItem(
                      icon: Icons.bolt,
                      label: "Energy",
                      active: selectedLog == "Energy",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              /// DYNAMIC TIP CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: neon,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: neon.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: neon,
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            selectedLog,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            selectedMessage,
                            style: const TextStyle(
                              color: Colors.white70,
                              height: 1.6,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildDot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget buildLegend(Color color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget buildInfoCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          const Spacer(),

          child,
        ],
      ),
    );
  }
}

class DayLabel extends StatelessWidget {
  final String text;

  const DayLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white54,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  final String text;
  final bool period;
  final bool fertile;
  final bool selected;

  const CalendarDay({
    super.key,
    required this.text,
    this.period = false,
    this.fertile = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    Color textColor = Colors.white;

    if (period) {
      bg = const Color(0xFFD4FF00);
      textColor = Colors.black;
    }

    if (fertile) {
      bg = Colors.cyan.withValues(alpha: 0.7);
      textColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: selected
            ? Border.all(
          color: const Color(0xFFD4FF00),
          width: 2,
        )
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const LogItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD4FF00);

    return Column(
      children: [

        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? neon.withValues(alpha: 0.15)
                : const Color(0xFF151515),
            border: Border.all(
              color: active ? neon : Colors.white10,
              width: active ? 2 : 1,
            ),
          ),
          child: Icon(
            icon,
            color: active ? neon : Colors.white70,
            size: 30,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          label,
          style: TextStyle(
            color: active ? neon : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}