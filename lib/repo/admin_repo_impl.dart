import 'package:shared_preferences/shared_preferences.dart';
import '../model/admin_config_model.dart';
import 'admin_repo.dart';

class AdminRepoImpl implements AdminRepo {
  @override
  Future<AdminConfigModel> loadAdminSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AdminConfigModel(
      globalChallengeName: prefs.getString('admin_global_challenge_name') ?? "Solstice 100k Squat Blast",
      systemNoticeText: prefs.getString('admin_system_notice_text') ?? "Scheduled backend database sync at midnight.",
      forcePremiumToAll: prefs.getBool('admin_force_premium') ?? false,
      enableVideoTutorials: prefs.getBool('flag_enable_videos') ?? true,
      enableTrainingSplits: prefs.getBool('flag_enable_splits') ?? true,
      showSystemNoticeAlert: prefs.getBool('flag_show_notice') ?? false,
      injectedExercisesList: prefs.getStringList('admin_custom_exercises') ?? [],
    );
  }

  @override
  Future<void> saveAdminSettings(AdminConfigModel config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('admin_global_challenge_name', config.globalChallengeName);
    await prefs.setString('admin_system_notice_text', config.systemNoticeText);
    await prefs.setBool('admin_force_premium', config.forcePremiumToAll);
    await prefs.setBool('flag_enable_videos', config.enableVideoTutorials);
    await prefs.setBool('flag_enable_splits', config.enableTrainingSplits);
    await prefs.setBool('flag_show_notice', config.showSystemNoticeAlert);
  }

  @override
  Future<void> saveCustomExercises(List<String> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('admin_custom_exercises', exercises);
  }

  @override
  Future<void> clearCustomExercises() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_custom_exercises');
  }
}