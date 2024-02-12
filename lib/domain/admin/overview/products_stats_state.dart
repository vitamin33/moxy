import 'package:flutter/material.dart';
import 'package:moxy/data/models/response/dashboard_response.dart';
import 'package:moxy/domain/copyable.dart';

class ProductsStatsState implements Copyable<ProductsStatsState> {
  final bool isLoading;
  final bool animated;
  final List<TotalByTimeFrame> ordersFromTimeFrame;
  final List<TotalByTimeFrame> saleFromTimeFrame;
  final String errorMessage;
  final DateTimeRange? selectedDate;

  ProductsStatsState({
    required this.isLoading,
    required this.animated,
    required this.ordersFromTimeFrame,
    required this.saleFromTimeFrame,
    required this.errorMessage,
    this.selectedDate,
  });

  static defaultState() {
    return ProductsStatsState(
        ordersFromTimeFrame: [],
        saleFromTimeFrame: [],
        isLoading: false,
        animated: false,
        selectedDate: null,
        errorMessage: '');
  }

  @override
  ProductsStatsState copyWith(
      {bool? isLoading,
      bool? animated,
      String? errorMessage,
      List<TotalByTimeFrame>? ordersFromTimeFrame,
      List<TotalByTimeFrame>? saleFromTimeFrame,
      DateTimeRange? selectedDate}) {
    return ProductsStatsState(
        isLoading: isLoading ?? this.isLoading,
        animated: animated ?? this.animated,
        ordersFromTimeFrame: ordersFromTimeFrame ?? this.ordersFromTimeFrame,
        saleFromTimeFrame: saleFromTimeFrame ?? this.saleFromTimeFrame,
        selectedDate: selectedDate ?? this.selectedDate,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
