import 'package:moxy/data/models/response/dashboard_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../../utils/common.dart';
import '../http/dio_client.dart';

class OverviewRepository {
  OverviewRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<NetworkDashboard, Exception>> getOverview(
      DateTime? fromDate, DateTime? toDate) async {
    try {
      final result = await client.getDashboard(fromDate, toDate);
      return Result.success(result);
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkDashboard, Exception>> getProductsStatistics(
      DateTime? fromDate, DateTime? toDate) async {
    try {
      final result = await client.getDashboard(fromDate, toDate);
      return Result.success(result);
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }
}
