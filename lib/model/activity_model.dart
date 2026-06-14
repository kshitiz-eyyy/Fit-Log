import 'daily_chart_data.dart';

class ActivityStateModel {
  final int targetCaloriesWeeklyBaseline;
  final List<Map<String, dynamic>> allActivities;
  final List<DailyChartData> weeklyChartData;

  ActivityStateModel({
    required this.targetCaloriesWeeklyBaseline,
    required this.allActivities,
    required this.weeklyChartData,
  });

  factory ActivityStateModel.initial() {
    return ActivityStateModel(
      targetCaloriesWeeklyBaseline: 2500,
      allActivities: [],
      weeklyChartData: [],
    );
  }

  ActivityStateModel copyWith({
    int? targetCaloriesWeeklyBaseline,
    List<Map<String, dynamic>>? allActivities,
    List<DailyChartData>? weeklyChartData,
  }) {
    return ActivityStateModel(
      targetCaloriesWeeklyBaseline: targetCaloriesWeeklyBaseline ?? this.targetCaloriesWeeklyBaseline,
      allActivities: allActivities ?? this.allActivities,
      weeklyChartData: weeklyChartData ?? this.weeklyChartData,
    );
  }
}