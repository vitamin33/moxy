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

  Future<Result<List<Order>, Exception>> getAllOrders() async {
    try {
      final result = await client.allOrders();
      final allOrdersList = orderMapper.mapToOrderList(result);
      final params = filterRepository.getFilterParams();
      final deliveryType = params.deliveryType.name.toString();
      final paymentType = params.paymentType.name.toString();
      final status = params.status;
      final dateRange = params.dateRange?.toString();
      final startData = dateRange?.split(' - ')[0].split(' ')[0];
      final endData = dateRange?.split(' - ')[1].split(' ')[0];

      List<Order> filteredOrders = allOrdersList.where((order) {
        bool matchesDelivery = deliveryType == 'empty' ||
            order.deliveryType.name == deliveryType;
        bool matchesPayment = paymentType == 'empty' ||
            order.paymentType.name == paymentType;
        bool matchesStatus = status.isEmpty ||
            status.any((s) => order.status.statusTitle.contains(s.statusTitle));
        bool matchesData = startData == null ||
            endData == null ||
            startData == endData ||
            (order.createdAt.compareTo(startData) >= 0 &&
                order.createdAt.compareTo(endData) <= 0);
        return matchesDelivery &&
            matchesPayment &&
            matchesStatus &&
            matchesData;
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
