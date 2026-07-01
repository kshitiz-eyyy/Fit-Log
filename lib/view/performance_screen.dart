import 'package:fitlog/theme/app_theme.dart';
import 'package:fitlog/viewmodel/performance_view_model.dart';
import 'package:flutter/material.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  late final PerformanceViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PerformanceViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _viewModel.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      _viewModel.setSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Performance'),
        actions: [
          IconButton(
            onPressed: _viewModel.loadHeatmap,
            icon: Icon(Icons.refresh, color: colors.textPrimary),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            if (_viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: colors.neonAccent),
              );
            }

            final dates = _viewModel.heatmapDates;
            final selectedKey = DateTime(
              _viewModel.selectedDate.year,
              _viewModel.selectedDate.month,
              _viewModel.selectedDate.day,
            );
            final selectedCount = _viewModel.activityCounts[selectedKey] ?? 0;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "PERFORMANCE",
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surfaceCard,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: colors.neonAccent),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: colors.neonAccent,
                            size: 35,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_viewModel.selectedDate.day}/${_viewModel.selectedDate.month}/${_viewModel.selectedDate.year}",
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$selectedCount activities logged",
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit_calendar,
                            color: colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "CONSISTENCY HEATMAP",
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Synced from Firebase activity logs (last 35 days)",
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surfaceCard,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: dates.isEmpty
                          ? Center(
                              child: Text(
                                "No activity data yet.\nLog workouts or meals to build your heatmap.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: colors.textSecondary),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: dates.map((date) {
                                  final count =
                                      _viewModel.activityCounts[date] ?? 0;
                                  final isSelected =
                                      date.year == selectedKey.year &&
                                      date.month == selectedKey.month &&
                                      date.day == selectedKey.day;

                                  return GestureDetector(
                                    onTap: () =>
                                        _viewModel.setSelectedDate(date),
                                    child: Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: _viewModel.heatColorForCount(
                                          count,
                                          neonAccent: colors.neonAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        border: isSelected
                                            ? Border.all(
                                                color: colors.textPrimary,
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
