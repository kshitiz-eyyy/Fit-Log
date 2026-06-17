
import '../model/admin_config_model.dart';

abstract class AdminRepo {
  Future<AdminConfigModel> loadAdminSettings();
  Future<void> saveAdminSettings(AdminConfigModel config);
  Future<void> saveCustomExercises(List<String> exercises);
  Future<void> clearCustomExercises();
}