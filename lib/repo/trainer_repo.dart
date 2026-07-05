
import '../model/trainer_model.dart';

abstract class TrainerRepo {

  Stream<List<TrainerModel>> getTrainersStream();
}