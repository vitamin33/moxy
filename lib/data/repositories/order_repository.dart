import 'dart:async';

import 'package:flutter/material.dart';
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
    await prefs.setStringList(statusKey, filterState.status);
    await prefs.setString(dateRangeKey, filterState.selectedDate.toString());
    _filterParamsStreamController.add(filterState);
  }

  FilterOrdersState getFilterParams() {
    final deliveryType = prefs.getString(deliveryTypeKey);
    final paymentType = prefs.getString(paymentTypeKey);
    final status = prefs.getStringList(statusKey);
    final dateRange = prefs.getString(dateRangeKey);
    final startData = dateRange?.split(' - ')[0];
    final endData = dateRange?.split(' - ')[1];

    return FilterOrdersState(
      paymentType: paymentType != null
          ? _parsePaymentType(paymentType)
          : FilterPaymentType.empty,
      deliveryType: deliveryType != null
          ? _parseDeliveryType(deliveryType)
          : FilterDeliveryType.empty,
      status: status ?? [],
      isLoading: false,
      selectedDate: DateTimeRange(
          start: DateTime.parse(startData ?? DateTime.now().toString()),
          end: DateTime.parse(endData ?? DateTime.now().toString())),
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
      final status = prefs.getStringList(statusKey);
      final dateRange = prefs.getString(dateRangeKey);
      final startData = dateRange?.split(' - ')[0].split(' ')[0];
      final endData = dateRange?.split(' - ')[1].split(' ')[0];

      List<Order> filteredOrders = allOrdersList.where((order) {
        bool matchesDelivery =
            deliveryType == 'empty' || order.deliveryType.name == deliveryType;
        bool matchesPayment =
            paymentType == 'empty' || order.paymentType.name == paymentType;
        bool matchesStatus =
            status!.isEmpty || status.any((s) => order.status.contains(s));
        bool matchesData = startData == endData ||
            (order.createdAt.compareTo(startData!) >= 0 &&
                order.createdAt.compareTo(endData!) <= 0);
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
}
