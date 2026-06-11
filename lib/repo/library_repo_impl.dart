import 'package:shared_preferences/shared_preferences.dart';
import '../model/library_model.dart';
import '../view/exercise_data.dart';
import 'library_repo.dart';

class LibraryRepoImpl implements LibraryRepo {
  @override
  Future<LibraryStateModel> getSynchronizedLibraryData() async {
    final prefs = await SharedPreferences.getInstance();

    final enableSplits = prefs.getBool('flag_enable_splits') ?? true;

    Map<String, List<Map<String, String>>> synchronizedData = {};
    exerciseData.forEach((key, value) {
      synchronizedData[key] = List<Map<String, String>>.from(value);
    });

    List<String> customInjections = prefs.getStringList('admin_custom_exercises') ?? [];

    for (String item in customInjections) {
      var parts = item.split('|');
      if (parts.length >= 2) {
        String exerciseName = parts[0];
        String targetCategory = parts[1];

        if (!synchronizedData.containsKey(targetCategory)) {
          synchronizedData[targetCategory] = [];
        }

        bool exists = synchronizedData[targetCategory]!.any((e) => e["name"] == exerciseName);
        if (!exists) {
          synchronizedData[targetCategory]!.add({
            "name": exerciseName,
            "reps": "10-12",
          });
        }
      }
    }

    return LibraryStateModel(
      dynamicExerciseData: synchronizedData,
      muscleGroups: synchronizedData.keys.toList(),
      enableTrainingSplitsFlag: enableSplits,
    );
  }
}