import 'package:flutter/foundation.dart';

import '../../data/models/response/all_orders_response.dart';
import '../copyable.dart';
import '../models/order.dart';
import '../models/product.dart';

class AllOrdersState implements Copyable<AllOrdersState> {
  final List<Order> allOrders;
  final bool isLoading;
  final String? errorMessage;

  AllOrdersState({
    required this.allOrders,
    required this.isLoading,
    this.errorMessage,
  });

  static AllOrdersState defaultAllProductsState() {
    return AllOrdersState(
      allOrders: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  AllOrdersState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Order>? allOrders,
  }) {
    return AllOrdersState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        allOrders: allOrders ?? this.allOrders);
  }
}