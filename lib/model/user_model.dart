class UserModel {
  final String id;
  final String name;
  final String email;
  final String? contact;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.contact,
    this.role = 'user',
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'role': role,
    };
  }


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      contact: map['contact'],
      role: map['role'] ?? 'user',
    );
  }
}