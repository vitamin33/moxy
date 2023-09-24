import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/models/status.dart';

import '../copyable.dart';

class FilterOrderParams implements Copyable<FilterOrderParams> {
  final FilterDeliveryType deliveryType;
  final FilterPaymentType paymentType;
  final List<Status> statuses;
  final DateTimeRange? dateRange;

  FilterOrderParams({
    required this.deliveryType,
    required this.paymentType,
    required this.statuses,
    required this.dateRange,
  });

  get selectedDate => null;

  static FilterOrderParams defaultFilterParams() {
    return FilterOrderParams(
      deliveryType: FilterDeliveryType.empty,
      paymentType: FilterPaymentType.empty,
      statuses: [],
      dateRange: null,
    );
  }

  @override
  FilterOrderParams copyWith({
    FilterDeliveryType? deliveryType,
    FilterPaymentType? paymentType,
    List<Status>? status,
    DateTimeRange? dateRange,
  }) {
    return FilterOrderParams(
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      statuses: status ?? this.statuses,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  ///custom comparing function to check if two params are equal
  bool isEqual(FilterOrderParams params) {
    return paymentType == params.paymentType &&
        deliveryType == params.deliveryType &&
        statuses == params.statuses &&
        dateRange == params.dateRange;
  }

  @override
  String toString() => '$paymentType, $deliveryType, $statuses, $dateRange';
}
