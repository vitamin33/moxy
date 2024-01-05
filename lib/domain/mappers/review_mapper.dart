import 'package:moxy/data/models/response/review_response.dart';
import 'package:moxy/domain/models/review.dart';


class ReviewMapper {
  List<Review> mapToReview(List<NetworkReview> networkPromos) {
    return networkPromos.map(
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
}
