import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // Current filtering context
  String _selectedFilter = "ALL";

  // Live dynamic mutable data list representing user activities
  final List<Map<String, dynamic>> _allActivities = [
    {
      "id": "1",
      "type": "TRAINING",
      "time": "07:15 AM",
      "title": "Lower Body Hypertrophy Block",
      "subtitle": "Leg Press, Romanian Deadlifts, Calf Complex",
      "metric": "Volume: 12,400 kg",
      "icon": Icons.fitness_center,
      "iconColor": const Color(0xFFCCFF00),
      "tag": "PR COOLDOWN",
      "showTag": true,
    },
    {
      "id": "2",
      "type": "NUTRITION",
      "time": "08:45 AM",
      "title": "Post-Workout Macro Intake",
      "subtitle": "Whey Isolate, Oats, Almond Butter Banana Bowl",
      "metric": "680 kcal • 52g Protein",
      "icon": Icons.restaurant,
      "iconColor": Colors.orangeAccent,
      "tag": "GOAL REACHED",
      "showTag": true,
    },
    {
      "id": "3",
      "type": "NUTRITION",
      "time": "11:20 AM",
      "title": "Hydration Marker Logged",
      "subtitle": "Pure Fluid Target Intake",
      "metric": "0.6 Liters Logged",
      "icon": Icons.water_drop,
      "iconColor": Colors.blueAccent,
      "tag": "",
      "showTag": false,
    },
    {
      "id": "4",
      "type": "TRAINING",
      "time": "Yesterday",
      "title": "Active Recovery Protocols",
      "subtitle": "Myofascial Foam Rolling & Deep Flexibility Work",
      "metric": "Duration: 45 Mins",
      "icon": Icons.accessibility_new,
      "iconColor": Colors.greenAccent,
      "tag": "COMPLETED",
      "showTag": true,
    },
  ];

  // Filters the list on the fly based on selected button
  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedFilter == "ALL") {
      return _allActivities;
    }
    return _allActivities.where((item) => item["type"] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "ACTIVITY ENGINE",
          style: TextStyle(
            color: Color(0xFFCCFF00),
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          // BUTTON: Wipes the history clean with a notification bar pop up
          IconButton(
            icon: const Icon(Icons.history_toggle_off, color: Colors.white),
            tooltip: "Clear History Log",
            onPressed: () {
              if (_allActivities.isEmpty) return;
              setState(() {
                _allActivities.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Activity logs successfully wiped clean."),
                  backgroundColor: Color(0xFF161616),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. PERFORMANCE HIGHLIGHT SUMMARY CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("WEEKLY VOLUME LOAD", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          Text(
                            _allActivities.isEmpty ? "0 kg" : "42,650 kg",
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: const Color(0xFFCCFF00).withValues(alpha: 0.1),
                        child: const Text("+8.4% VS LAST WEEK", style: TextStyle(color: Color(0xFFCCFF00), fontSize: 9, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Visual Load Distribution Chart Bars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _chartColumn("MON", _allActivities.isEmpty ? 0 : 45, false),
                      _chartColumn("TUE", _allActivities.isEmpty ? 0 : 70, false),
                      _chartColumn("WED", _allActivities.isEmpty ? 0 : 15, false),
                      _chartColumn("THU", _allActivities.isEmpty ? 0 : 90, true), // Today active highlight
                      _chartColumn("FRI", 0, false),
                      _chartColumn("SAT", 0, false),
                      _chartColumn("SUN", 0, false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. METRIC STRIP SUMMARY SUB-GRID
            Row(
              children: [
                Expanded(
                  child: _miniMetricCard(
                      Icons.bolt,
                      "TOTAL WORKOUTS",
                      "${_allActivities.where((e) => e["type"] == "TRAINING").length} Sessions"
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _miniMetricCard(
                      Icons.star_border,
                      "PR ACHIEVED",
                      _allActivities.isEmpty ? "0 Records" : "4 Records"
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3. LOG SELECTION TIMELINE FILTER STRIP
            Row(
              children: [
                _filterButton("ALL"),
                const SizedBox(width: 8),
                _filterButton("TRAINING"),
                const SizedBox(width: 8),
                _filterButton("NUTRITION"),
              ],
            ),
            const SizedBox(height: 16),

            // 4. CHRONOLOGICAL TIMELINE STREAM LISTENER
            _filteredActivities.isEmpty
                ? Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: Column(
                children: const [
                  Icon(Icons.layers_clear, color: Colors.grey, size: 36),
                  SizedBox(height: 12),
                  Text(
                    "No logged records match current criteria.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredActivities.length,
              itemBuilder: (context, index) {
                final item = _filteredActivities[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: _timelineEventCard(
                    id: item["id"],
                    time: item["time"],
                    title: item["title"],
                    subtitle: item["subtitle"],
                    metric: item["metric"],
                    icon: item["icon"],
                    iconColor: item["iconColor"],
                    tag: item["tag"],
                    showTag: item["showTag"],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Changes filter category dynamically when clicked
  Widget _filterButton(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFCCFF00) : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // Custom bar charts
  Widget _chartColumn(String label, double heightPercentage, bool isActive) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 24,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(1),
          ),
          child: Container(
            height: heightPercentage,
            width: 24,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFCCFF00) : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFFCCFF00) : Colors.grey,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Summary box widget elements
  Widget _miniMetricCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFCCFF00), size: 14),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  // Timeline Event Card with direct trash/delete tap tracking
  Widget _timelineEventCard({
    required String id,
    required String time,
    required String title,
    required String subtitle,
    required String metric,
    required IconData icon,
    required Color iconColor,
    required String tag,
    required bool showTag,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade900, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  if (showTag)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      margin: const EdgeInsets.only(right: 8),
                      color: const Color(0xFFCCFF00),
                      child: Text(
                        tag,
                        style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  // TRASH TRIGGER: Removes specific item from data list instantly
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _allActivities.removeWhere((element) => element["id"] == id);
                      });
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent.withValues(alpha: 0.8),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.3),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade900, height: 1),
          const SizedBox(height: 10),
          Text(
            metric,
            style: TextStyle(color: iconColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}