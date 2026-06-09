import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/trainer_model.dart';

class TrainerRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Emits an asynchronous stream of compiled Trainer models directly from the database
  Stream<List<TrainerModel>> getTrainersStream() {
    return _firestore.collection('trainers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TrainerModel.fromSnapshot(doc)).toList();
    });
  }
}