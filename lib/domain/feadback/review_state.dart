import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/review.dart';

class ReviewState implements Copyable<ReviewState> {
  final bool isLoading;
  final List<Review> reviewsList;
  final String errorMessage;

  ReviewState({
    required this.isLoading,
    required this.reviewsList,
    required this.errorMessage,
  });

  static defaultReviewState() {
    return ReviewState(
      isLoading: false,
      reviewsList: [Review.defaultReview()],
      errorMessage: '',
    );
  }

  @override
  ReviewState copyWith({
    bool? isLoading,
    List<Review>? reviewsList,
    String? errorMessage,
  }) {
    return ReviewState(
      isLoading: isLoading ?? this.isLoading,
      reviewsList: reviewsList ?? this.reviewsList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}