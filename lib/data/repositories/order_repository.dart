import 'dart:async';

import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/admin/filter_orders/filter_orders_state.dart';
import '../../domain/mappers/order_mapper.dart';
import '../../domain/models/order.dart';
import '../../utils/common.dart';
import '../models/request/create_order_request.dart';
import '../models/request/edit_order_request.dart';

class OrderRepository {
  final orderMapper = locate<OrderMapper>();
  final DioClient client = locate<DioClient>();
  final filterRepository = locate<FilterRepository>();
  late SharedPreferences prefs;
  final _filterParamsStreamController = StreamController<FilterOrdersState>();
  Stream<FilterOrdersState> get filterParamsStream =>
      _filterParamsStreamController.stream;

  OrderRepository() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Result<List<Order>, Exception>> getPaginatedAllOrders(
      [int page = 1]) async {
    try {
      final result = await client.paginatedAllOrders(page);
      final allOrdersList = orderMapper.mapToOrderList(result);

      return Result.success(allOrdersList);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<List<Order>, Exception>> getPaginatedFilterOrders(
      [int page = 1]) async {
    try {
      final filterParams = filterRepository.getFilterParams();
      final result = await client.paginatedFilterOrders(filterParams, page);
      final filterOrdersList = orderMapper.mapToOrderList(result);

      return Result.success(filterOrdersList);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<Order, Exception>> getOrderById(String orderId) async {
    try {
      final result = await client.getOrderById(orderId);

      return Result.success(orderMapper.mapToOrder(result));
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
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

  Future<Result<dynamic, Exception>> editOrderStatus(
      EditStatusOrder order) async {
    try {
      final result = await client.editOrderStatus(order);
      return Result.success(result);
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }
}
