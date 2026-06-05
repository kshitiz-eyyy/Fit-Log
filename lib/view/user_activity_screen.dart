import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _selectedFilter = "ALL";
  bool _isLoading = true;
  int _targetCaloriesWeeklyBaseline = 2500;

  List<Map<String, dynamic>> _allActivities = [];
  List<DailyChartData> _weeklyChartData = [];

  @override
  void initState() {
    super.initState();
    _loadCombinedActivityHistory();
  }

  Future<void> _loadCombinedActivityHistory() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    _targetCaloriesWeeklyBaseline = prefs.getInt('target_calories') ?? 2500;

    List<Map<String, dynamic>> resolvedLogs = [];
    List<DailyChartData> chartDataTemp = [];
    DateTime today = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      DateTime checkDate = today.subtract(Duration(days: i));
      String dateKey = "${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}";

      int dailyCals = prefs.getInt('calories_$dateKey') ?? 0;
      String? mealsRawJson = prefs.getString('meals_$dateKey');
      String? workoutsRawJson = prefs.getString('workouts_$dateKey');

      String dayLabel = _getDayLabel(checkDate.weekday);
      if (i == 0) dayLabel = "TODAY";

      chartDataTemp.add(DailyChartData(
        label: dayLabel,
        calories: dailyCals,
        isToday: i == 0,
      ));

      if (workoutsRawJson != null) {
        Map<String, dynamic> decodedWorkouts = jsonDecode(workoutsRawJson);
        decodedWorkouts.forEach((workoutId, data) {
          resolvedLogs.add({
            "id": workoutId,
            "type": "TRAINING",
            "time": i == 0 ? "Today • Workout" : "$dateKey • Workout",
            "title": data['title'].toString(),
            "subtitle": "Tracked Performance Log",
            "metric": data['metric'].toString(),
            "icon": Icons.fitness_center,
            "iconColor": const Color(0xFFCCFF00),
            "tag": i == 0 ? "TODAY" : "COMPLETED",
            "showTag": true,
            "storageKey": "workouts_$dateKey"
          });
        });
      }

      if (mealsRawJson != null) {
        Map<String, dynamic> decodedMeals = jsonDecode(mealsRawJson);
        decodedMeals.forEach((mealType, data) {
          if (data['name'] != null && data['name'].toString().isNotEmpty) {
            resolvedLogs.add({
              "id": "nutri_${dateKey}_$mealType",
              "type": "NUTRITION",
              "time": i == 0 ? "Today • $mealType" : "$dateKey • $mealType",
              "title": data['name'].toString(),
              "subtitle": "Macros: P: ${data['protein']}g • C: ${data['carbs']}g • F: ${data['fats']}g",
              "metric": "${data['calories']} kcal",
              "icon": Icons.restaurant,
              "iconColor": Colors.orangeAccent,
              "tag": i == 0 ? "TODAY" : "PAST LOG",
              "showTag": true,
              "storageKey": "meals_$dateKey",
              "mealTypeKey": mealType
            });
          }
        });
      }
    }

    if (resolvedLogs.isEmpty) {
      resolvedLogs.addAll([
        {
          "id": "mock_train_1",
          "type": "TRAINING",
          "time": "07:15 AM",
          "title": "Lower Body Hypertrophy Block",
          "subtitle": "Leg Press, Romanian Deadlifts, Calf Complex",
          "metric": "Volume: 12,400 kg",
          "icon": Icons.fitness_center,
          "iconColor": const Color(0xFFCCFF00),
          "tag": "PR COOLDOWN",
          "showTag": true,
          "isMock": true
        },
        {
          "id": "mock_train_2",
          "type": "TRAINING",
          "time": "Yesterday",
          "title": "Active Recovery Protocols",
          "subtitle": "Myofascial Foam Rolling & Deep Flexibility Work",
          "metric": "Duration: 45 Mins",
          "icon": Icons.accessibility_new,
          "iconColor": Colors.greenAccent,
          "tag": "COMPLETED",
          "showTag": true,
          "isMock": true
        }
      ]);
    }

    setState(() {
      _allActivities = resolvedLogs;
      _weeklyChartData = chartDataTemp;
      _isLoading = false;
    });
  }

  Future<void> _deleteLogItem(Map<String, dynamic> item) async {
    if (item["isMock"] == true) {
      setState(() {
        _allActivities.removeWhere((element) => element["id"] == item["id"]);
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? storageKey = item["storageKey"];
    String id = item["id"];

    if (storageKey != null) {
      String? rawJson = prefs.getString(storageKey);
      if (rawJson != null) {
        Map<String, dynamic> decodedData = jsonDecode(rawJson);
        if (item["type"] == "NUTRITION" && item["mealTypeKey"] != null) {
          decodedData.remove(item["mealTypeKey"]);
        } else {
          decodedData.remove(id);
        }
        await prefs.setString(storageKey, jsonEncode(decodedData));
      }
    }
    _loadCombinedActivityHistory();
  }

  String _getDayLabel(int weekday) {
    switch (weekday) {
      case 1: return "MON";
      case 2: return "TUE";
      case 3: return "WED";
      case 4: return "THU";
      case 5: return "FRI";
      case 6: return "SAT";
      case 7: return "SUN";
      default: return "";
    }
  }

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedFilter == "ALL") return _allActivities;
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
        centerTitle: true,
        title: const Text(
          "ACTIVITY",
          style: TextStyle(
            color: Color(0xFFCCFF00),
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: "Sync Logs",
            onPressed: _loadCombinedActivityHistory,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00)))
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("WEEKLY CALORIC INTAKE TIMELINE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          Text(
                            "${_weeklyChartData.map((e) => e.calories).fold(0, (prev, element) => prev + element)} kcal total",
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: const Color(0xFFCCFF00).withOpacity(0.1),
                        child: Text("LIMIT: $_targetCaloriesWeeklyBaseline", style: const TextStyle(color: Color(0xFFCCFF00), fontSize: 9, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 120,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: (_targetCaloriesWeeklyBaseline * 1.2),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => const Color(0xFF222222),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                "${_weeklyChartData[group.x].label}\n${rod.toY.round()} kcal",
                                const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, fontSize: 11),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int idx = value.toInt();
                                if (idx >= 0 && idx < _weeklyChartData.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(_weeklyChartData[idx].label, style: TextStyle(color: _weeklyChartData[idx].isToday ? const Color(0xFFCCFF00) : Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (val) {
                            return FlLine(
                              color: val == _targetCaloriesWeeklyBaseline ? const Color(0xFFCCFF00).withOpacity(0.3) : Colors.white.withOpacity(0.02),
                              strokeWidth: val == _targetCaloriesWeeklyBaseline ? 1.5 : 0.5,
                              dashArray: val == _targetCaloriesWeeklyBaseline ? [4, 4] : null,
                            );
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(_weeklyChartData.length, (idx) {
                          final data = _weeklyChartData[idx];
                          bool overLimit = data.calories > _targetCaloriesWeeklyBaseline;
                          return BarChartGroupData(
                            x: idx,
                            barRods: [
                              BarChartRodData(
                                toY: data.calories.toDouble(),
                                color: overLimit ? Colors.orangeAccent : (data.isToday ? const Color(0xFFCCFF00) : Colors.grey.shade800),
                                width: 16,
                                borderRadius: BorderRadius.circular(1),
                              )
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _miniMetricCard(
                      Icons.bolt,
                      "TOTAL SESSIONS",
                      "${_allActivities.where((e) => e["type"] == "TRAINING").length} Workouts"
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _miniMetricCard(
                      Icons.restaurant_menu,
                      "NUTRITION ENTRIES",
                      "${_allActivities.where((e) => e["type"] == "NUTRITION").length} Logged"
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            _filteredActivities.isEmpty
                ? Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Icon(Icons.layers_clear, color: Colors.grey, size: 36),
                  SizedBox(height: 12),
                  Text("No logs match current filters.", style: TextStyle(color: Colors.grey, fontSize: 13)),
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
                    item: item,
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

  Widget _filterButton(String label) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFCCFF00) : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ),
    );
  }

  Widget _miniMetricCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(4)),
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

  Widget _timelineEventCard({
    required Map<String, dynamic> item,
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
                  Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  if (showTag)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      margin: const EdgeInsets.only(right: 8),
                      color: const Color(0xFFCCFF00),
                      child: Text(tag, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  GestureDetector(
                    onTap: () => _deleteLogItem(item),
                    child: Icon(Icons.delete_outline, color: Colors.redAccent.withOpacity(0.8), size: 18),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.3)),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade900, height: 1),
          const SizedBox(height: 10),
          Text(metric, style: TextStyle(color: iconColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        ],
      ),
    );
  }
}

class DailyChartData {
  final String label;
  final int calories;
  final bool isToday;

  DailyChartData({required this.label, required this.calories, required this.isToday});
}