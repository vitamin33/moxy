import 'package:flutter/material.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product_stats.dart';

class ProductsStatsState implements Copyable<ProductsStatsState> {
  final bool isLoading;
  final List<ProductOrderCountStat> orderCountStats;
  final List<ProductProfitStat> profitStats;
  final String? errorMessage;

  ProductsStatsState({
    required this.isLoading,
    required this.orderCountStats,
    required this.profitStats,
    this.errorMessage,
  });

  static defaultState() {
    return ProductsStatsState(
      orderCountStats: [],
      profitStats: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  ProductsStatsState copyWith({
    bool? isLoading,
    bool? animated,
    String? errorMessage,
    List<ProductOrderCountStat>? orderCountStats,
    List<ProductProfitStat>? profitStats,
    DateTimeRange? selectedDate,
  }) {
    return ProductsStatsState(
      isLoading: isLoading ?? this.isLoading,
      orderCountStats: orderCountStats ?? this.orderCountStats,
      profitStats: profitStats ?? this.profitStats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
