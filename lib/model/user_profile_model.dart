class UserModel {
  final String id;
  final String name;
  final String? contact;
  final String email;

  final String bio;
  final String fitnessGoal;
  final String role;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'user_bio': bio,
      'fitness_goal': fitnessGoal,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'],
      email: map['email'] ?? '',
      bio: map['user_bio'] ?? 'Consistency beats talent every single day.',
      fitnessGoal: map['fitness_goal'] ?? 'Hypertrophy Conditioning',
      role: map['role'] ?? 'user',
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    this.contact,
    required this.email,
    required this.bio,
    required this.fitnessGoal,
    required this.role,
  });
}