class UserModel {
  final String id;
  final String name;
  final String? contact;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'],
      email: map['email'] ?? '',
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    this.contact,
    required this.email,
  });
}
