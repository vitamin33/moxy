import 'dart:async';

import 'package:moxy/constants.dart';
import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/services/get_it.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/order_constants.dart';
import '../../domain/admin/filter_orders/filter_orders_state.dart';
import '../../domain/mappers/order_mapper.dart';
import '../../domain/models/order.dart';
import '../../utils/common.dart';
import '../models/request/create_order_request.dart';
import '../models/request/edit_order_request.dart';

class OrderRepository {
  final orderMapper = locate<OrderMapper>();
  final DioClient client = locate<DioClient>();
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

  Future<void> saveFilterParams(FilterOrdersState filterState) async {
    await prefs.setString(
        deliveryTypeKey, filterState.deliveryType.name.toString());
    await prefs.setString(
        paymentTypeKey, filterState.paymentType.name.toString());
    await prefs.setString(statusKey, filterState.status.toString());
    _filterParamsStreamController.add(filterState);
  }

  FilterOrdersState getFilterParams() {
    final deliveryType = prefs.getString(deliveryTypeKey);
    final paymentType = prefs.getString(paymentTypeKey);
    final status = prefs.getString(statusKey);

    return FilterOrdersState(
      paymentType: paymentType != null
          ? _parsePaymentType(paymentType)
          : FilterPaymentType.empty,
      deliveryType: deliveryType != null
          ? _parseDeliveryType(deliveryType)
          : FilterDeliveryType.empty,
      status: status,
      isLoading: false,
      selectedDate: null,
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
    );
  }

  FilterPaymentType _parsePaymentType(String paymentType) {
    switch (paymentType) {
      case 'cashAdvance':
        return FilterPaymentType.cashAdvance;
      case 'fullPayment':
        return FilterPaymentType.fullPayment;
      default:
        return FilterPaymentType.empty;
    }
  }

  FilterDeliveryType _parseDeliveryType(String deliveryType) {
    switch (deliveryType) {
      case 'novaPost':
        return FilterDeliveryType.novaPost;
      case 'ukrPost':
        return FilterDeliveryType.ukrPost;
      default:
        return FilterDeliveryType.empty;
    }
  }

  Future<Result<List<Order>, Exception>> getAllOrders() async {
    try {
      final result = await client.allOrders();
      final allOrdersList = orderMapper.mapToOrderList(result);
      final deliveryType = prefs.getString(deliveryTypeKey);
      final paymentType = prefs.getString(paymentTypeKey);
      final status = prefs.getString(statusKey);
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

  void clearDeliveryTypeFilter() async {
    await prefs.remove(deliveryTypeKey);
  }

  void clearPaymentTypeFilter() async {
    await prefs.remove(paymentTypeKey);
  }

  void clearStatusFilter() async {
    await prefs.remove(statusKey);
  }

  void clearDateRangeFilter() async {
    await prefs.remove(dateRangeKey);
  }
}
