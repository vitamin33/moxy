import 'dart:async';

import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../domain/mappers/order_mapper.dart';
import '../../domain/models/order.dart';
import '../../utils/common.dart';
import '../models/request/create_order_request.dart';
import '../models/request/edit_order_request.dart';

class OrderRepository {
  final orderMapper = locate<OrderMapper>();
  final DioClient client = locate<DioClient>();
  final filterRepository = locate<FilterRepository>();

  Future<Result<List<Order>, Exception>> getAllOrders() async {
    try {
      final result = await client.allOrders();
      final allOrdersList = orderMapper.mapToOrderList(result);
      final params = filterRepository.getFilterParams();
      final deliveryType = params.deliveryType;
      final paymentType = params.paymentType;
      final status = params.status;

      // TOOD use this dateRange
      final dateRange = params.dateRange;
      List<Order> filteredOrders = allOrdersList.where((order) {
        bool matchesDelivery = order.deliveryType != deliveryType;
        bool matchesPayment = order.paymentType != paymentType;
        bool matchesStatus = order.status != status;
        return matchesDelivery && matchesPayment && matchesStatus;
      }).toList();

      return Result.success(filteredOrders);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<dynamic, Exception>> addOrder(CreateOrder order) async {
    try {
      final result = await client.createOrder(order);
      return Result.success(result);
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<dynamic, Exception>> editOrder(EditOrder order) async {
    try {
      final result = await client.editOrder(order);
      return Result.success(result);
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }
}
