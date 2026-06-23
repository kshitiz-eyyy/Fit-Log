class UserModel {
  final String id;
  final String name;
  final String? contact;
  final String email;
  final String? handle;
  final String? bio;
  final String? profileImageUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'handle': handle,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'role': 'user',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      contact: map['contact'] as String?,
      email: map['email'] as String? ?? '',
      handle: map['handle'] as String?,
      bio: map['bio'] as String?,
      profileImageUrl: map['profileImageUrl'] as String?,
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    this.contact,
    required this.email,
    this.handle,
    this.bio,
    this.profileImageUrl,
  });
}
