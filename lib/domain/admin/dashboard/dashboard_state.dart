import 'package:flutter/material.dart';
import 'package:moxy/data/models/response/dashboard_response.dart';
import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  final bool isLoading;
  final bool animated;
  final int totalSale;
  final int totalCost;
  final int totalOrders;
  final int previousTotalSaleValue;
  final int previousTotalCostValue;
  final int previousTotalOrdersCount;
  final double saleValuePercentageChange;
  final double costValuePercentageChange;
  final double ordersCountPercentageChange;
  final List<TotalByTimeFrame> ordersFromTimeFrame;
  final List<TotalByTimeFrame> saleFromTimeFrame;
  final List<TotalByTimeFrame> costFromTimeFrame;
  final String errorMessage;
  final DateTimeRange? selectedDate;

  DashboardState(
      {required this.isLoading,
      required this.animated,
      required this.totalSale,
      required this.totalCost,
      required this.totalOrders,
      required this.previousTotalSaleValue,
      required this.previousTotalCostValue,
      required this.previousTotalOrdersCount,
      required this.saleValuePercentageChange,
      required this.costValuePercentageChange,
      required this.ordersCountPercentageChange,
      required this.ordersFromTimeFrame,
      required this.saleFromTimeFrame,
      required this.costFromTimeFrame,
      required this.errorMessage,
      this.selectedDate});

  static defaultDashboardState() {
    return DashboardState(
        totalSale: 0,
        totalCost: 0,
        totalOrders: 0,
        previousTotalSaleValue: 0,
        previousTotalCostValue: 0,
        previousTotalOrdersCount: 0,
        saleValuePercentageChange: 0,
        costValuePercentageChange: 0,
        ordersCountPercentageChange: 0,
        selectedDate: null,
        ordersFromTimeFrame: [],
        saleFromTimeFrame: [],
        costFromTimeFrame: [],
        isLoading: false,
        animated: false,
        errorMessage: '');
  }

  @override
  DashboardState copyWith(
      {
        bool? isLoading,
        bool? animated,
      String? errorMessage,
      int? totalSale,
      int? totalCost,
      int? totalOrders,
      int? previousTotalSaleValue,
      int? previousTotalCostValue,
      int? previousTotalOrdersCount,
      double? saleValuePercentageChange,
      double? costValuePercentageChange,
      double? ordersCountPercentageChange,
      List<TotalByTimeFrame>? ordersFromTimeFrame,
      List<TotalByTimeFrame>? saleFromTimeFrame,
      List<TotalByTimeFrame>? costFromTimeFrame,
      DateTimeRange? selectedDate}) {
    return DashboardState(
        totalSale: totalSale ?? this.totalSale,
        isLoading: isLoading ?? this.isLoading,
        animated: animated ?? this.animated,
        totalCost: totalCost ?? this.totalCost,
        totalOrders: totalOrders ?? this.totalOrders,
        previousTotalSaleValue:
            previousTotalSaleValue ?? this.previousTotalSaleValue,
        previousTotalCostValue:
            previousTotalCostValue ?? this.previousTotalCostValue,
        previousTotalOrdersCount:
            previousTotalOrdersCount ?? this.previousTotalOrdersCount,
        saleValuePercentageChange:
            saleValuePercentageChange ?? this.saleValuePercentageChange,
        costValuePercentageChange:
            costValuePercentageChange ?? this.costValuePercentageChange,
        ordersCountPercentageChange:
            ordersCountPercentageChange ?? this.ordersCountPercentageChange,
        ordersFromTimeFrame: ordersFromTimeFrame ?? this.ordersFromTimeFrame,
        saleFromTimeFrame: saleFromTimeFrame ?? this.saleFromTimeFrame,
        costFromTimeFrame: costFromTimeFrame ?? this.costFromTimeFrame,
        selectedDate: selectedDate ?? this.selectedDate,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
