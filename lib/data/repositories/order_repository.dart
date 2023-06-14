import 'package:moxy/data/dio_client.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/common.dart';
import '../models/request/create_order_request.dart';
import '../models/response/all_orders_response.dart';

class OrderRepository {
  static DioClient client = DioClient.instance;
  Future<Result<List<NetworkOrder>, Exception>> getAllOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final result = await client.allOrders(token);
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('Result is null'));
      }
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

   Future<Result<dynamic, Exception>> addOrder(CreateOrder order) async {
    try {
       final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      // final result = await client.allOrders(token);
      final result = (await client.createOrder(
          order.deliveryType,
          order.paymentType,
          order.novaPostNumber,
          order.selectedProducts,
          order.client,
          order.status,
          token
         ));
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
