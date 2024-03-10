import 'package:moxy/domain/copyable.dart';

class Review implements Copyable<Review> {
  final String clientName;
  final String reviewText;
  final int rating;
  final String productId;
  final String avatarImageUrl;

  Review({
    required this.clientName,
    required this.reviewText,
    required this.rating,
    required this.productId,
    required this.avatarImageUrl,
  });

  static Review defaultReview() {
    return Review(
        clientName: '',
        reviewText: '',
        rating: 0,
        productId: '',
        avatarImageUrl: '');
  }

  @override
  Review copyWith({
    String? clientName,
    String? reviewText,
    int? rating,
    String? productId,
    String? avatarImageUrl,
  }) {
    return Review(
      clientName: clientName ?? this.clientName,
      reviewText: reviewText ?? this.reviewText,
      rating: rating ?? this.rating,
      productId: productId ?? this.productId,
      avatarImageUrl: avatarImageUrl ?? this.avatarImageUrl,
    );
  }
}

class ReviewStats implements Copyable<ReviewStats> {
  final List<Review> reviews;
  final String avgRating;
  final int totalVotes;

  ReviewStats({
    required this.reviews,
    required this.avgRating,
    required this.totalVotes,
  });

  static ReviewStats defaultReviewStats() {
    return ReviewStats(
      reviews: [],
      avgRating: '0.0',
      totalVotes: 0,
    );
  }

  @override
  ReviewStats copyWith({
    List<Review>? reviews,
    String? avgRating,
    int? totalVotes,
  }) {
    return ReviewStats(
      reviews: reviews ?? this.reviews,
      avgRating: avgRating ?? this.avgRating,
      totalVotes: totalVotes ?? this.totalVotes,
    );
  }
}
