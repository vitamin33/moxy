import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';

import '../copyable.dart';

class FilterOrderParams implements Copyable<FilterOrderParams> {
  final FilterDeliveryType deliveryType;
  final FilterPaymentType paymentType;
  final List<String> status;
  final DateTimeRange? dateRange;

  FilterOrderParams({
    required this.deliveryType,
    required this.paymentType,
    required this.status,
    required this.dateRange,
  });

  get selectedDate => null;

  static FilterOrderParams defaultFilterParams() {
    return FilterOrderParams(
      deliveryType: FilterDeliveryType.empty,
      paymentType: FilterPaymentType.empty,
      status: [],
      dateRange: null,
    );
  }

  @override
  FilterOrderParams copyWith({
    FilterDeliveryType? deliveryType,
    FilterPaymentType? paymentType,
    List<String>? status,
    DateTimeRange? dateRange,
  }) {
    return FilterOrderParams(
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  ///custom comparing function to check if two params are equal
  bool isEqual(FilterOrderParams params) {
    return paymentType == params.paymentType &&
        deliveryType == params.deliveryType &&
        status == params.status &&
        dateRange == params.dateRange;
  }

  @override
  String toString() => '$paymentType, $deliveryType, $status, $dateRange';
}
