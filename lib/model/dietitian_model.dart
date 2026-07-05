import 'package:cloud_firestore/cloud_firestore.dart';

class DietitianModel {
  final String id;
  final String name;
  final String contact;
  final String experience;
  final String location;

  DietitianModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.experience,
    required this.location,
  });

  factory DietitianModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return DietitianModel(
      id: doc.id,
      name: data['Name']?.toString() ?? 'Unknown Dietitian',
      contact: data['Contact']?.toString() ?? 'N/A',
      experience: data['Experience']?.toString() ?? 'N/A',
      location: data['Location']?.toString() ?? 'N/A',
    );
  }
}