import '../model/water_log_model.dart';

abstract class WaterRepository {
  /// Fetches unique hydration values using the live logged-in user ID
  Future<WaterConfig> fetchUserWaterConfig(String userId);

  /// Updates the reminder setting back to the unique user's document
  Future<void> updateUserReminderSetting(String userId, bool active);

  /// Saves the specific current intake value straight into the dynamic user profile
  Future<void> updateUserCurrentIntake(String userId, double currentIntake);

  /// Saves the chosen notification interval text straight to Firestore
  Future<void> updateUserFrequencySetting(String userId, String frequency);

  /// Fetches logs for the specific user and date
  Future<List<WaterLogItem>> fetchWaterLogs(String userId);

  /// Saves the entire list of logs for the day
  Future<void> saveWaterLogs(String userId, List<WaterLogItem> logs);
}