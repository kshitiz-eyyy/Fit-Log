import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/firebase_user_helper.dart';
import 'rate_repo.dart';

class RateRepoImpl implements RateRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
