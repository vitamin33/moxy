import 'package:flutter/material.dart';

import '../../../constant/order_constants.dart';
import '../../copyable.dart';

class FilterOrdersState implements Copyable<FilterOrdersState> {
  bool isLoading;
  FilterDeliveryType deliveryType;
  FilterPaymentType paymentType;
  List<String> status;
  DateTimeRange selectedDate;
  String createdAt;
  String updatedAt;

  FilterOrdersState({
    required this.isLoading,
    required this.deliveryType,
    required this.paymentType,
    required this.status,
    required this.selectedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  static FilterOrdersState defaultFilterOrdersState() {
    return FilterOrdersState(
        isLoading: false,
        deliveryType: FilterDeliveryType.empty,
        paymentType: FilterPaymentType.empty,
        status: [],
        selectedDate: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
        createdAt: '',
        updatedAt: '');
  }

  @override
  FilterOrdersState copyWith(
      {bool? isLoading,
      FilterDeliveryType? deliveryType,
      FilterPaymentType? paymentType,
      List<String>? status,
      DateTimeRange? selectedDate,
      String? createdAt,
      String? updatedAt}) {
    return FilterOrdersState(
      isLoading: isLoading ?? this.isLoading,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
