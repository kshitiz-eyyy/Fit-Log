import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PeriodCycleScreen extends StatefulWidget {
  const PeriodCycleScreen({super.key});

  @override
  State<PeriodCycleScreen> createState() => _PeriodCycleScreenState();
}

class _PeriodCycleScreenState extends State<PeriodCycleScreen> {
  DateTime currentDate = DateTime(2026, 7, 1); // starting date
  int dayCount = 12;

  // Example heatmap data (last 5 cycles, 10 days each for simplicity)
  final List<List<int>> heatmapData = List.generate(
    5,
        (cycle) => List.generate(10, (day) => (day + cycle) % 3),
  );

  void _nextDay() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
      dayCount++;
    });
  }

  void _previousDay() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
      dayCount = dayCount > 1 ? dayCount - 1 : 1;
    });
  }

  Color _getHeatmapColor(int value) {
    switch (value) {
      case 0:
        return Colors.green.shade200;
      case 1:
        return Colors.green.shade400;
      case 2:
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM d, yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PERIOD"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phase and Date
            Text(
              "Follicular Phase",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              "Day $dayCount",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),

            const SizedBox(height: 16),

            // Date navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousDay,
                  child: const Text("Previous Day"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _nextDay,
                  child: const Text("Next Day"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Heatmap Title
            const Text(
              "Cycle Consistency Heatmap (Last 5 Cycles)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
            const SizedBox(height: 12),

            // Heatmap Grid (wrapped to avoid overflow)
            Expanded(
              child: ListView.builder(
                itemCount: heatmapData.length,
                itemBuilder: (context, cycleIndex) {
                  return Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: heatmapData[cycleIndex].map((value) {
                      return Container(
                        width: 20,
                        height: 20,
                        color: _getHeatmapColor(value),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cycle Start", style: TextStyle(color: Colors.white)),
                Text("Cycle End", style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
