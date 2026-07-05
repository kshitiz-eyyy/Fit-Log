import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fitlog/model/water_log_model.dart';
import 'package:fitlog/repo/water_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late WaterRepositoryImpl waterRepository;
  const String userId = 'test_user_123';

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    waterRepository = WaterRepositoryImpl(firestore: fakeFirestore);
  });

  group('WaterRepositoryImpl Tests', () {
    test('fetchUserWaterConfig should return default config if document does not exist', () async {
      final config = await waterRepository.fetchUserWaterConfig(userId);

      expect(config.dailyGoal, 3.5);
      expect(config.isReminderActive, false);
      expect(config.frequency, 'Every 1 hour');
    });

    test('fetchUserWaterConfig should return data from Firestore if document exists', () async {
      // Seed the fake database
      await fakeFirestore.collection('users').doc(userId).set({
        'hydration_amount': 2.5,
        'hydration_reminder_active': true,
        'hydration_reminder_frequency': 'Every 2 hours',
      });

      final config = await waterRepository.fetchUserWaterConfig(userId);

      expect(config.dailyGoal, 2.5);
      expect(config.isReminderActive, true);
      expect(config.frequency, 'Every 2 hours');
    });

    test('updateUserReminderSetting should update Firestore correctly', () async {
      await fakeFirestore.collection('users').doc(userId).set({'name': 'Test User'});

      await waterRepository.updateUserReminderSetting(userId, true);

      final doc = await fakeFirestore.collection('users').doc(userId).get();
      expect(doc.data()?['hydration_reminder_active'], true);
    });

    test('updateUserCurrentIntake should update Firestore correctly', () async {
      await fakeFirestore.collection('users').doc(userId).set({'name': 'Test User'});

      await waterRepository.updateUserCurrentIntake(userId, 1.5);

      final doc = await fakeFirestore.collection('users').doc(userId).get();
      expect(doc.data()?['current_water_intake'], 1.5);
    });

    test('updateUserFrequencySetting should update Firestore correctly', () async {
      await fakeFirestore.collection('users').doc(userId).set({'name': 'Test User'});

      await waterRepository.updateUserFrequencySetting(userId, 'Every 30 minutes');

      final doc = await fakeFirestore.collection('users').doc(userId).get();
      expect(doc.data()?['hydration_reminder_frequency'], 'Every 30 minutes');
    });

    test('update methods should not crash if userId is empty', () async {
      // Testing the guards in the implementation
      await expectLater(waterRepository.updateUserReminderSetting('', true), completes);
      await expectLater(waterRepository.updateUserCurrentIntake('', 2.0), completes);
      await expectLater(waterRepository.updateUserFrequencySetting('', 'Never'), completes);
    });
  });
}
