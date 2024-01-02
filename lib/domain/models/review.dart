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
      clientName:'',
      reviewText: '',
      rating: 0,
      productId: '',
      avatarImageUrl:''
    );
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