import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/quote_model.dart'; // Adjust paths if necessary
import 'quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<QuoteModel>> fetchAllQuotes() async {
    try {
      // Accesses your "quotes" collection created in Step 1
      final querySnapshot = await _firestore.collection('quotes').get();

      return querySnapshot.docs
          .map((doc) => QuoteModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception("Failed to load quotes from Firebase: $e");
    }
  }
}