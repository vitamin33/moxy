import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/models/response/review_response.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class ReviewRepository {
  ReviewRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<List<NetworkReview>, Exception>> getReviews() async {
    try {
      final result = await client.fetchReviews();
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<ProductReviewsResponse, Exception>> getReviewsStatsForProduct(
      String productId) async {
    try {
      final result = await client.fetchReviewStatsForProduct(productId);
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      return Result.success(ProductReviewsResponse([], 'n/a', 0));
    }
  }
}
