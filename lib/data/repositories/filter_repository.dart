import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/constant/order_status.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/filter_order_param.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/order_constants.dart';
import '../../domain/models/status.dart';

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
    await prefs.setString(dateRangeKey, range.toString());
    notifyFilterParamsChange();
  }

  Future<void> saveStatusFilterParam(List<Status> status) async {
    final List<String> valueStatusList =
        status.map((e) => e.statusValue.name).toList();
    await prefs.setStringList(statusKey, valueStatusList);
    notifyFilterParamsChange();
  }

  Future<void> removeItemStatusFilterParam(item) async {
    List<String> statusList = prefs.getStringList('status') ?? [];
    statusList.remove(item);
    await prefs.setStringList(statusKey, statusList);
    notifyFilterParamsChange();
  }

  FilterOrderParams getFilterParams() {
    final deliveryType = prefs.getString(deliveryTypeKey);
    final paymentType = prefs.getString(paymentTypeKey);
    final status = prefs.getStringList(statusKey);
    final dateRangeType = prefs.getString(dateRangeKey);

    return FilterOrderParams(
      paymentType: paymentType != null
          ? _parsePaymentType(paymentType)
          : FilterPaymentType.empty,
      deliveryType: deliveryType != null
          ? _parseDeliveryType(deliveryType)
          : FilterDeliveryType.empty,
      status: status != null ? _parseStatus(status) : [],
      dateRange: dateRangeType != null ? _parseDataRange(dateRangeType) : null,
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


  List<Status> _parseStatus(List<String> statusList) {
    List<Status> result = [];
    for (var status in statusList) {
      for (var item in allStatusOrder) {
        if (item.statusTitle == status) {
          result.add(Status(
              iconPath: item.iconPath,
              isSelected: item.isSelected,
              statusTitle: item.statusTitle,
              statusValue: item.statusValue));
          break;
        }
      }
    }
    return result;
  }

  DateTimeRange _parseDataRange(String dataRange) {
    List<String> dateParts = dataRange.split(" - ");
    DateTime startDate =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dateParts[0]);
    DateTime endDate =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dateParts[1]);
    return DateTimeRange(start: startDate, end: endDate);
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
