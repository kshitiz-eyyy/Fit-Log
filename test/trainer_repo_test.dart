import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitlog/model/trainer_model.dart';
import 'package:fitlog/repo/trainer_repo_impl.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late TrainerRepoImpl repo;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repo = TrainerRepoImpl(firestore: fakeFirestore);
  });

  test('getTrainersStream emits an empty list when no trainers exist', () async {
    // Act & Assert
    expect(repo.getTrainersStream(), emits(isEmpty));
  });

  test('getTrainersStream emits all saved trainers correctly', () async {
    // 1. Arrange: Add mock trainers directly into the fake firestore database
    await fakeFirestore.collection('trainers').add({
      'Name': 'Kritika Sharma',
      'Contact': '9812345678',
      'Experience': '3 Years',
      'Specialization': 'Yoga',
      'Location': 'Lalitpur',
    });

    await fakeFirestore.collection('trainers').add({
      'Name': 'Ram Bahadur',
      'Contact': '9841112233',
      'Experience': '10 Years',
      'Specialization': 'Crossfit',
      'Location': 'Pokhara',
    });

    // 2. Act & Assert: Listen to the stream and verify lists
    expect(
      repo.getTrainersStream(),
      emits(
        isA<List<TrainerModel>>()
            .having((list) => list.length, 'length', 2)
            .having((list) => list[0].name, 'first trainer name', 'Kritika Sharma')
            .having((list) => list[1].name, 'second trainer name', 'Ram Bahadur'),
      ),
    );
  });
}