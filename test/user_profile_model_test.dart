import 'package:flutter_test/flutter_test.dart';
import 'package:fitlog/model/user_model.dart'; // Update this to your correct path

void main() {
  group('UserModel Tests', () {
    test('fromMap should correctly map all required fields', () {
      final map = {
        'id': 'u123',
        'name': 'John Doe',
        'contact': '9876543210',
        'email': 'john@test.com',
      };

      final user = UserModel.fromMap(map);

      expect(user.id, 'u123');
      expect(user.name, 'John Doe');
      expect(user.contact, '9876543210');
      expect(user.email, 'john@test.com');
    });

    test('toMap should output the correct map structure', () {
      const user = UserModel(
        id: 'u456',
        name: 'Jane Doe',
        contact: '1234567890',
        email: 'jane@test.com', bio: '', fitnessGoal: '', role: '',
      );

      final map = user.toMap();

      expect(map['id'], 'u456');
      expect(map['name'], 'Jane Doe');
      expect(map['contact'], '1234567890');
      expect(map['email'], 'jane@test.com');
    });
  });
}