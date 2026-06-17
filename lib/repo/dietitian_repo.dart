import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/dietitian_model.dart';

class DietitianRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DietitianModel>> getDietitianStream() {
    return _firestore.collection('dietitian').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => DietitianModel.fromSnapshot(doc)).toList();
    });
  }
}