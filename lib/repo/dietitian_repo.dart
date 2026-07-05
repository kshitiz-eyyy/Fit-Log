import '../model/dietitian_model.dart';

abstract class DietitianRepo {

  Stream<List<DietitianModel>> getDietitianStream();
}