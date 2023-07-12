import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';

import '../../copyable.dart';
import '../../models/order.dart';

class AllOrdersState implements Copyable<AllOrdersState> {
  final List<Order> allOrders;
  final bool isLoading;
  final FilterDeliveryType deliveryFilter;
  final FilterPaymentType paymentFilter;
  final List<String> statusFilter;
  final DateTimeRange? dateRangeFilter;
  final String? errorMessage;

  AllOrdersState({
    required this.allOrders,
    required this.deliveryFilter,
    required this.paymentFilter,
    required this.statusFilter,
    required this.dateRangeFilter,
    required this.isLoading,
    this.errorMessage,
  });

  static AllOrdersState defaultAllProductsState() {
    return AllOrdersState(
      allOrders: [],
      deliveryFilter: FilterDeliveryType.empty,
      paymentFilter: FilterPaymentType.empty,
      statusFilter: [],
      dateRangeFilter: null,
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  AllOrdersState copyWith({
    bool? isLoading,
    String? errorMessage,
    FilterDeliveryType? deliveryFilter,
    FilterPaymentType? paymentFilter,
    List<String>? statusFilter,
    DateTimeRange? dateRangeFilter,
    List<Order>? allOrders,
  }) {
    return AllOrdersState(
        isLoading: isLoading ?? this.isLoading,
        deliveryFilter: deliveryFilter ?? this.deliveryFilter,
        paymentFilter: paymentFilter ?? this.paymentFilter,
        statusFilter: statusFilter ?? this.statusFilter,
        dateRangeFilter: dateRangeFilter ?? this.dateRangeFilter,
        errorMessage: errorMessage ?? this.errorMessage,
        allOrders: allOrders ?? this.allOrders);
  }

  bool hasFilters() {
    return deliveryFilter != FilterDeliveryType.empty ||
        paymentFilter != FilterPaymentType.empty ||
        statusFilter.isNotEmpty == true ||
        dateRangeFilter != null;
  }
}
