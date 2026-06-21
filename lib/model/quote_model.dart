import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteModel {
  final String id;
  final String text;

  QuoteModel({
    required this.id,
    required this.text,
  });


  factory QuoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return QuoteModel(
      id: doc.id,
      text: data?['text'] ?? 'Keep pushing forward!', 
    );
  }
}