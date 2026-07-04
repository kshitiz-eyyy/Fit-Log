import 'dart:math';

class PeriodRepository {
  // Simulate fetching heatmap data (5 cycles, 10 days each)
  List<List<int>> fetchHeatmapData() {
    final random = Random();
    return List.generate(
      5,
          (cycle) => List.generate(10, (day) => random.nextInt(3)),
    );
  }
}
