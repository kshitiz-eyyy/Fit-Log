class UserModel {
  final String id;
  final String name;
  final String? contact;
  final String email;
  final String? handle;
  final String bio;
  final String fitnessGoal;
  final String role;
  final String? profileImageUrl;
  final int? age;
  final String? height;
  final String? weight;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'handle': handle,
      'bio': bio,
      'fitness_goal': fitnessGoal,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      contact: map['contact'] as String?,
      email: map['email'] as String? ?? '',
      handle: map['handle'] as String?,
      bio: map['bio'] as String? ?? 'Consistency beats talent every single day.',
      fitnessGoal: map['fitness_goal'] as String? ?? 'Hypertrophy Conditioning',
      role: map['role'] as String? ?? 'user',
      profileImageUrl: map['profileImageUrl'] as String?,
      age: map['age'] as int?,
      height: map['height'] as String?,
      weight: map['weight'] as String?,
    );
  }

  const UserModel({
    required this.id,
    required this.name,
    this.contact,
    required this.email,
    this.handle,
    required this.bio,
    required this.fitnessGoal,
    required this.role,
    this.profileImageUrl,
    this.age,
    this.height,
    this.weight,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? contact,
    String? email,
    String? handle,
    String? bio,
    String? fitnessGoal,
    String? role,
    String? profileImageUrl,
    int? age,
    String? height,
    String? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      handle: handle ?? this.handle,
      bio: bio ?? this.bio,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
