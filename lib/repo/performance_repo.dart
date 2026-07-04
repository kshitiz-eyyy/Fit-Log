abstract class PerformanceRepo {
  Future<Map<DateTime, int>> fetchActivityHeatmap({int days = 35});
}
