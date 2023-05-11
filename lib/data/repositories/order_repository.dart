import 'package:moxy/data/dio_client.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/response/all_orders_response.dart';

class OrderRepository {
  static DioClient client = DioClient.instance;
  Future<Result<List<Order>, Exception>> getAllOrders() async {
    try {
      final result = await client.allOrders();
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('Result is null'));
      }
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}
