abstract class RateRepo {
  Future<void> submitReview({
    required int rating,
    required String feedback,
  });
}
