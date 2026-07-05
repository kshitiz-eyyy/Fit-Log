import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitlog/repo/rate_repo_impl.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late RateRepoImpl repo;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repo = RateRepoImpl(firestore: fakeFirestore);
    // Override userId for testing
    FirebaseUserHelper.currentUserId = 'testUser123';
  });

  test('submitReview saves review in user subcollection', () async {
    await repo.submitReview(rating: 4, feedback: 'Great app!');

    final snapshot = await fakeFirestore
        .collection('users')
        .doc('testUser123')
        .collection('app_reviews')
        .get();

    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.data()['rating'], 4);
    expect(snapshot.docs.first.data()['feedback'], 'Great app!');
  });

  test('submitReview also updates user doc with last rating', () async {
    await repo.submitReview(rating: 5, feedback: 'Awesome!');

    final userDoc =
    await fakeFirestore.collection('users').doc('testUser123').get();

    expect(userDoc.exists, true);
    expect(userDoc.data()?['lastAppRating'], 5);
    expect(userDoc.data()?['lastAppFeedback'], 'Awesome!');
  });
}
