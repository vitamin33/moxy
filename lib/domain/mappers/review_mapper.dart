import 'package:moxy/data/models/response/review_response.dart';
import 'package:moxy/domain/models/review.dart';

class ReviewMapper {
  List<Review> mapToReviews(List<NetworkReview> networkReviews) {
    return networkReviews.map(
      (p) {
        return Review(
            clientName: p.clientName,
            reviewText: p.reviewText,
            rating: p.rating,
            productId: p.productId,
            avatarImageUrl: p.avatarImageUrl);
      },
    ).toList();
  }

  ReviewStats mapToReviewStats(ProductReviewsResponse networkReviwStats) {
    final reviews = mapToReviews(networkReviwStats.allReview ?? []);
    return ReviewStats(
      reviews: reviews,
      avgRating: networkReviwStats.avgRating,
      totalVotes: networkReviwStats.totalVotes,
    );
  }
}
