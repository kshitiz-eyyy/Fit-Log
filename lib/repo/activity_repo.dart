
import '../model/activity_model.dart';


abstract class ActivityRepo {
  Future<ActivityStateModel> loadCombinedActivityHistory();
  Future<void> deleteLogItem(Map<String, dynamic> item);
}