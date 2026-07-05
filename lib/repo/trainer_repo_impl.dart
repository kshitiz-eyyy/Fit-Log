import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/trainer_model.dart';
import 'trainer_repo.dart';

class TrainerRepoImpl implements TrainerRepo {
  final FirebaseFirestore _firestore;

  // ✅ Updated constructor to allow injecting a mock database
  TrainerRepoImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<TrainerModel>> getTrainersStream() {
    return _firestore.collection('trainers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TrainerModel.fromSnapshot(doc)).toList();
    });
  }
}