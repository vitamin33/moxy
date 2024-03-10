import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_response.g.dart';

@JsonSerializable()
class AllReviewResponse {
  List<NetworkReview>? allReview;

  AllReviewResponse(this.allReview);

  factory AllReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$AllReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllReviewResponseToJson(this);
}

@JsonSerializable()
class ProductReviewsResponse {
  List<NetworkReview>? allReview;
  String avgRating;
  int totalVotes;

  ProductReviewsResponse(
    this.allReview,
    this.avgRating,
    this.totalVotes,
  );

  factory ProductReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewsResponseToJson(this);
}

@JsonSerializable()
class NetworkReview {
  @JsonKey(name: '_id')
  String? id;
  String clientName;
  String reviewText;
  int rating;
  String productId;
  String avatarImageUrl;

  NetworkReview({
    this.id,
    required this.clientName,
    required this.reviewText,
    required this.rating,
    required this.productId,
    required this.avatarImageUrl,
  });

  factory NetworkReview.fromJson(Map<String, dynamic> json) =>
      _$NetworkReviewFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkReviewToJson(this);
}
