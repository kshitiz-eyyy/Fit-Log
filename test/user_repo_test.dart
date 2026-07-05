import 'package:fitlog/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fitlog/repo/user_repo_impl.dart';

import 'mocks.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockDocumentReference<Map<String, dynamic>> mockDoc;
  late UserRepoImpl repo;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDoc = MockDocumentReference();

    repo = UserRepoImpl(auth: mockAuth, firestore: mockFirestore);
  });

  group('UserRepoImpl', () {
    test('addUser calls Firestore set', () async {
      final user = UserModel(id: 'u1', name: 'Test', contact: '123', email: 'test@test.com', bio: '', fitnessGoal: '', role: '');

      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(user.id)).thenReturn(mockDoc);
      when(mockDoc.set(user.toMap())).thenAnswer((_) async => {});

      await repo.addUser(user);

      verify(mockDoc.set(user.toMap())).called(1);
    });

    test('deleteUser calls Firestore delete', () async {
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc('u1')).thenReturn(mockDoc);
      when(mockDoc.delete()).thenAnswer((_) async => {});

      await repo.deleteUser('u1');

      verify(mockDoc.delete()).called(1);
    });

    test('editProfile calls Firestore update', () async {
      final user = UserModel(id: 'u1', name: 'Updated', contact: '999', email: 'updated@test.com', bio: '', fitnessGoal: '', role: '');

      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(user.id)).thenReturn(mockDoc);
      when(mockDoc.update(user.toMap())).thenAnswer((_) async => {});

      await repo.editProfile(user);

      verify(mockDoc.update(user.toMap())).called(1);
    });

    test('forgetPassword calls sendPasswordResetEmail', () async {
      when(mockAuth.sendPasswordResetEmail(email: 'test@test.com')).thenAnswer((_) async => {});

      await repo.forgetPassword('test@test.com');

      verify(mockAuth.sendPasswordResetEmail(email: 'test@test.com')).called(1);
    });

    test('getAllUser returns list of UserModels', () async {
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockQueryDoc = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc]);
      when(mockQueryDoc.data()).thenReturn({
        'id': 'u1',
        'name': 'Test User',
        'contact': '1234567890',
        'email': 'test@test.com',
      });

      final users = await repo.getAllUser();

      expect(users.length, 1);
      expect(users.first.name, 'Test User');
    });

    test('getUserByID returns UserModel when found', () async {
      final mockDocSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc('u1')).thenReturn(mockDoc);
      when(mockDoc.get()).thenAnswer((_) async => mockDocSnapshot);
      when(mockDocSnapshot.data()).thenReturn({
        'id': 'u1',
        'name': 'Test User',
        'contact': '1234567890',
        'email': 'test@test.com',
      });

      final user = await repo.getUserByID('u1');

      expect(user.id, 'u1');
      expect(user.name, 'Test User');
    });

    test('login returns userId', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(mockAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('u123');

      final result = await repo.login('test@test.com', 'password');

      expect(result, 'u123');
    });

    test('register returns userId', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(mockAuth.createUserWithEmailAndPassword(
        email: 'new@test.com',
        password: 'password',
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('u456');

      final result = await repo.register('new@test.com', 'password');

      expect(result, 'u456');
    });

    test('logout calls signOut', () async {
      when(mockAuth.signOut()).thenAnswer((_) async => {});

      await repo.logout();

      verify(mockAuth.signOut()).called(1);
    });
  });
}
