import 'package:fitlog/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../viewmodel/track_membership_view_model.dart';

class TrackMembershipScreen extends StatefulWidget {
  const TrackMembershipScreen({super.key});

  @override
  State<TrackMembershipScreen> createState() => _TrackMembershipScreenState();
}

class _TrackMembershipScreenState extends State<TrackMembershipScreen> {
  late final TrackMembershipViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TrackMembershipViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          "Membership Tracking",
          style: TextStyle(
            color: colors.neonAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _viewModel.loadMembership,
            icon: Icon(Icons.refresh, color: colors.textPrimary),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          if (_viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colors.neonAccent),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: CircularProgressIndicator(
                          value: _viewModel.progress,
                          strokeWidth: 12,
                          backgroundColor: colors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colors.neonAccent,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${_viewModel.daysRemaining}",
                            style: TextStyle(
                              color: colors.neonAccent,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "DAYS REMAINING",
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "of ${_viewModel.totalDays}-day cycle",
                            style: TextStyle(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: colors.surfaceElevated,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _viewModel.isActive
                              ? colors.neonAccent
                              : colors.textSecondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _viewModel.isActive ? "ACTIVE PLAN" : "INACTIVE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: colors.background,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _viewModel.planName,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _viewModel.planSubtitle,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _viewModel.tier,
                        style: TextStyle(
                          color: colors.neonAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: colors.textSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Cycle Reset Date: ${DateFormat('MMMM dd, yyyy').format(_viewModel.cycleResetDate)}",
                            style: TextStyle(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.neonAccent,
                      foregroundColor: colors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _viewModel.isSaving
                        ? null
                        : () async {
                            final success = await _viewModel.refreshCycle();
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Cycle refreshed and saved to Firebase!'
                                      : _viewModel.errorMessage ??
                                            'Failed to refresh cycle.',
                                ),
                              ),
                            );
                          },
                    child: _viewModel.isSaving
                        ? SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: colors.background,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Refresh Current Cycle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: _viewModel.isSaving
                      ? null
                      : () async {
                          final success = await _viewModel.resetProgressData();
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Membership progress reset in Firebase.'
                                    : _viewModel.errorMessage ??
                                          'Failed to reset progress.',
                              ),
                            ),
                          );
                        },
                  child: Text(
                    "Reset Progress Data",
                    style: TextStyle(color: colors.textSecondary),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
