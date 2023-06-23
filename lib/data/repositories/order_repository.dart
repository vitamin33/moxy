import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/services/get_it.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/models/city.dart';
import '../../utils/common.dart';
import '../models/request/create_order_request.dart';
import '../models/response/all_orders_response.dart';

class OrderRepository {
  final DioClient client = locate<DioClient>();

  Future<Result<List<NetworkOrder>, Exception>> getAllOrders() async {
    try {
      final result = await client.allOrders();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<dynamic, Exception>> addOrder(CreateOrder order) async {
    try {
      final result = await client.createOrder(order);
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('sd'));
      }
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }

}
