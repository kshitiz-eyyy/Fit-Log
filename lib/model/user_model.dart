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
      'bio': bio,
      'fitnessGoal': fitnessGoal,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      contact: map['contact'] as String?,
      email: map['email'] as String,
      bio: map['bio'] as String? ?? '',
      fitnessGoal: map['fitnessGoal'] as String? ?? '',
      role: map['role'] as String? ?? '',
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    this.contact,
    required this.email,
    this.bio = '',
    this.fitnessGoal = '',
    this.role = '',
  });
}
