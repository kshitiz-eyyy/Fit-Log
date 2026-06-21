import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../viewmodel/track_membership_view_model.dart';
import 'features_screen.dart'; // Imported to point back cleanly

class TrackMembershipScreen extends StatefulWidget {
  const TrackMembershipScreen({super.key});

  @override
  State<TrackMembershipScreen> createState() => _TrackMembershipScreenState();
}

class _TrackMembershipScreenState extends State<TrackMembershipScreen> {
  // Instantiate the ViewModel
  final TrackMembershipViewModel _viewModel = TrackMembershipViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true, // Centers the title text layout
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Clears stack and opens FeaturesScreen directly
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => FeaturesScreen()),
                  (route) => false,
            );
          },
        ),
        title: const Text(
          "Performance Tracking",
          style: TextStyle(
            color: Color(0xFFD4FF00), // Clean layout matching green accent
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Listens to ViewModel updates dynamically
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Circular Progress Tracker
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
                          backgroundColor: Colors.grey.shade900,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFD4FF00),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${_viewModel.daysRemaining}",
                            style: const TextStyle(
                              color: Color(0xFFD4FF00),
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "DAYS REMAINING",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "of ${_viewModel.totalDays}-day cycle",
                            style: const TextStyle(
                              color: Colors.white54,
                            ),
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
                    color: const Color(0xFF141414),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4FF00),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "ACTIVE PLAN",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Standard Track",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        "Full Access Tracker",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Cycle Reset Date: ${DateFormat('MMMM dd, yyyy').format(_viewModel.cycleResetDate)}",
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // Primary Action Button (Refresh Cycle)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4FF00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      _viewModel.refreshCycle();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cycle refreshed successfully!')),
                      );
                    },
                    child: const Text(
                      "Refresh Current Cycle",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Secondary option (Reset Data)
                TextButton(
                  onPressed: () {
                    _viewModel.resetProgressData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tracking progress cleared.')),
                    );
                  },
                  child: const Text(
                    "Reset Progress Data",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
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