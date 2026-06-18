import 'package:cloud_firestore/cloud_firestore.dart';

class TermsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> fetchTerms() async {
    try {

      DocumentSnapshot doc = await _firestore.collection('app_terms').doc('terms').get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        return data['text'] ?? 'No terms available.';
      }
      return 'Terms document not found.';
    } catch (e) {
      return 'Error loading terms: $e';
    }
  }
}