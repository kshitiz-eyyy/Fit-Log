class UserModel {
  final String id;
  final String name;
  final String? contact;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'contact': this.contact,
      'email': this.email,
    };
  }


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      contact: map['contact'] as String,
      email: map['email'] as String,
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
  });
}


