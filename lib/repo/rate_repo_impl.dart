import 'package:cloud_firestore/cloud_firestore.dart';
import 'rate_repo.dart';

/// Temporary helper for tests (replace with your real FirebaseUserHelper later)
class FirebaseUserHelper {
  static String currentUserId = 'testUser123';
}

class RateRepoImpl implements RateRepo {
  final FirebaseFirestore _firestore;

  // ✅ Constructor allows injecting FakeFirebaseFirestore in tests
  RateRepoImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> submitReview({
    required int rating,
    required String feedback,
  }) async {
    final userId = FirebaseUserHelper.currentUserId;
    final reviewRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('app_reviews')
        .doc();

    await reviewRef.set({
      'rating': rating,
      'feedback': feedback,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _firestore.collection('users').doc(userId).set(
      {
        'lastAppRating': rating,
        'lastAppFeedback': feedback,
        'lastReviewAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}
