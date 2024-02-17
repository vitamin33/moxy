import 'package:moxy/data/models/response/dashboard_response.dart';
import 'package:moxy/data/models/response/products_stats_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';

class OverviewRepository {
  OverviewRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<NetworkDashboard, Exception>> getOverview(
      DateTime? fromDate, DateTime? toDate) async {
    final result = await client.getDashboard(fromDate, toDate);
    return Result.success(result);
  }

  Future<Result<NetworkProductStats, Exception>> getProductsStatistics(
      DateTime? fromDate, DateTime? toDate) async {
    final result = await client.getProductStats(fromDate, toDate);
    return Result.success(result);
  }
}
