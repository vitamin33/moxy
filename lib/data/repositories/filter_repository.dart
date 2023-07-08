import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/filter_order_param.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/order_constants.dart';

class FilterRepository {
  late SharedPreferences prefs;

  final _filterParamsStreamController = StreamController<FilterOrderParams>();
  Stream<FilterOrderParams> get filterParamsStream =>
      _filterParamsStreamController.stream;

  FilterRepository() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> notifyFilterParams(FilterOrderParams filterParams) async {
    _filterParamsStreamController.add(filterParams);
  }

  Future<void> savePaymentFilterParam(FilterPaymentType type) async {
    await prefs.setString(paymentTypeKey, type.name.toString());
    notifyFilterParamsChange();
  }

  Future<void> saveDeliveryFilterParam(FilterDeliveryType type) async {
    await prefs.setString(deliveryTypeKey, type.name.toString());
    notifyFilterParamsChange();
  }

  Future<void> saveDateRangeFilterParam(DateTimeRange range) async {
    // TODO implement saving of date range
    await prefs.setString(dateRangeKey, range.toString());
    notifyFilterParamsChange();
  }

  Future<void> saveStatusFilterParam(String status) async {
    await prefs.setString(statusKey, status);
    notifyFilterParamsChange();
  }

  FilterOrderParams getFilterParams() {
    final deliveryType = prefs.getString(deliveryTypeKey);
    final paymentType = prefs.getString(paymentTypeKey);
    final status = prefs.getString(statusKey);

    return FilterOrderParams(
      paymentType: paymentType != null
          ? _parsePaymentType(paymentType)
          : FilterPaymentType.empty,
      deliveryType: deliveryType != null
          ? _parseDeliveryType(deliveryType)
          : FilterDeliveryType.empty,
      status: status,
      dateRange: null,
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

  void clearDeliveryTypeFilter() async {
    await prefs.remove(deliveryTypeKey);
    notifyFilterParamsChange();
  }

  void clearPaymentTypeFilter() async {
    await prefs.remove(paymentTypeKey);
    notifyFilterParamsChange();
  }

  void clearStatusFilter() async {
    await prefs.remove(statusKey);
    notifyFilterParamsChange();
  }

  void clearDateRangeFilter() async {
    await prefs.remove(dateRangeKey);
    notifyFilterParamsChange();
  }

  void notifyFilterParamsChange() {
    final current = getFilterParams();
    _filterParamsStreamController.add(current);
  }

  void resetFilterParams() async {
    await prefs.remove(deliveryTypeKey);
    await prefs.remove(paymentTypeKey);
    await prefs.remove(statusKey);
    await prefs.remove(dateRangeKey);
    notifyFilterParamsChange();
  }
}
