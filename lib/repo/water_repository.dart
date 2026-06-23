import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/water_log_model.dart';


class WaterRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches unique hydration values using the live logged-in user ID
  Future<WaterConfig> fetchUserWaterConfig(String userId) async {
    try {
      if (userId.isEmpty) return WaterConfig(dailyGoal: 3.5, isReminderActive: false, frequency: 'Every 1 hour');

      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        return WaterConfig.fromFirestore(data);
      }
    } catch (e) {
      print("Error fetching user water config: $e");
    }
    return WaterConfig(dailyGoal: 3.5, isReminderActive: false, frequency: 'Every 1 hour');
  }

  /// Updates the reminder setting back to the unique user's document
  Future<void> updateUserReminderSetting(String userId, bool active) async {
    if (userId.isEmpty) return;
    try {
      await _firestore.collection('users').doc(userId).update({
        'hydration_reminder_active': active,
      });
    } catch (e) {
      print("Error updating reminder flag: $e");
    }
  }

  /// Saves the specific current intake value straight into the dynamic user profile
  Future<void> updateUserCurrentIntake(String userId, double currentIntake) async {
    if (userId.isEmpty) return;
    try {
      await _firestore.collection('users').doc(userId).update({
        'current_water_intake': currentIntake,
      });
    } catch (e) {
      print("Error updating hydration amount: $e");
    }
  }

  /// Saves the chosen notification interval text straight to Firestore
  Future<void> updateUserFrequencySetting(String userId, String frequency) async {
    if (userId.isEmpty) return;
    try {
      await _firestore.collection('users').doc(userId).update({
        'hydration_reminder_frequency': frequency,
      });
      print("🟢 Firebase Updated: Saved reminder frequency ($frequency)");
    } catch (e) {
      print("🔴 Firebase Error updating frequency: $e");
    }
  }
}