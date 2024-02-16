import 'package:flutter/material.dart';
import 'package:moxy/data/models/response/dashboard_response.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/ads_report.dart';
import 'package:moxy/domain/models/product_stats.dart';

class DashboardState implements Copyable<DashboardState> {
  final bool isLoading;
  final bool animated;
  final int totalSale;
  final int totalCost;
  final int totalOrders;
  final int totalProfit;
  final int previousTotalSaleValue;
  final int previousTotalCostValue;
  final int previousTotalOrdersCount;
  final int previousTotalProfit;
  final double saleValuePercentageChange;
  final double costValuePercentageChange;
  final double ordersCountPercentageChange;
  final double profitPercentageChange;
  final List<TotalByTimeFrame> ordersFromTimeFrame;
  final List<TotalByTimeFrame> saleFromTimeFrame;
  final List<TotalByTimeFrame> costFromTimeFrame;
  final List<TotalByTimeFrame> profitFromTimeFrame;
  final AdsReport currentAdsReport;
  final AdsReport previousAdsReport;
  final ProductStats stats;
  final String errorMessage;
  final DateTimeRange? selectedDate;

  DashboardState({
    required this.isLoading,
    required this.animated,
    required this.totalSale,
    required this.totalCost,
    required this.totalOrders,
    required this.totalProfit,
    required this.previousTotalSaleValue,
    required this.previousTotalCostValue,
    required this.previousTotalOrdersCount,
    required this.previousTotalProfit,
    required this.saleValuePercentageChange,
    required this.costValuePercentageChange,
    required this.ordersCountPercentageChange,
    required this.profitPercentageChange,
    required this.ordersFromTimeFrame,
    required this.saleFromTimeFrame,
    required this.costFromTimeFrame,
    required this.profitFromTimeFrame,
    required this.currentAdsReport,
    required this.previousAdsReport,
    required this.stats,
    required this.errorMessage,
    this.selectedDate,
  });

  static defaultDashboardState() {
    return DashboardState(
      totalSale: 0,
      totalCost: 0,
      totalOrders: 0,
      totalProfit: 0,
      previousTotalSaleValue: 0,
      previousTotalCostValue: 0,
      previousTotalOrdersCount: 0,
      previousTotalProfit: 0,
      saleValuePercentageChange: 0,
      costValuePercentageChange: 0,
      ordersCountPercentageChange: 0,
      profitPercentageChange: 0,
      ordersFromTimeFrame: [],
      saleFromTimeFrame: [],
      costFromTimeFrame: [],
      profitFromTimeFrame: [],
      currentAdsReport: AdsReport.defaultReport(),
      previousAdsReport: AdsReport.defaultReport(),
      stats: ProductStats.defaultStats(),
      isLoading: false,
      animated: false,
      selectedDate: null,
      errorMessage: '',
    );
  }

  @override
  DashboardState copyWith(
      {bool? isLoading,
      bool? animated,
      String? errorMessage,
      int? totalSale,
      int? totalCost,
      int? totalOrders,
      int? totalProfit,
      int? previousTotalSaleValue,
      int? previousTotalCostValue,
      int? previousTotalOrdersCount,
      int? previousTotalProfit,
      double? saleValuePercentageChange,
      double? costValuePercentageChange,
      double? ordersCountPercentageChange,
      double? profitPercentageChange,
      List<TotalByTimeFrame>? orderCountStats,
      List<TotalByTimeFrame>? profitStats,
      List<TotalByTimeFrame>? costFromTimeFrame,
      List<TotalByTimeFrame>? profitFromTimeFrame,
      AdsReport? currentAdsReport,
      AdsReport? previousAdsReport,
      ProductStats? stats,
      DateTimeRange? selectedDate}) {
    return DashboardState(
        totalSale: totalSale ?? this.totalSale,
        isLoading: isLoading ?? this.isLoading,
        animated: animated ?? this.animated,
        totalCost: totalCost ?? this.totalCost,
        totalProfit: totalProfit ?? this.totalProfit,
        totalOrders: totalOrders ?? this.totalOrders,
        previousTotalSaleValue:
            previousTotalSaleValue ?? this.previousTotalSaleValue,
        previousTotalCostValue:
            previousTotalCostValue ?? this.previousTotalCostValue,
        previousTotalOrdersCount:
            previousTotalOrdersCount ?? this.previousTotalOrdersCount,
        previousTotalProfit: previousTotalProfit ?? this.previousTotalProfit,
        saleValuePercentageChange:
            saleValuePercentageChange ?? this.saleValuePercentageChange,
        costValuePercentageChange:
            costValuePercentageChange ?? this.costValuePercentageChange,
        ordersCountPercentageChange:
            ordersCountPercentageChange ?? this.ordersCountPercentageChange,
        profitPercentageChange:
            profitPercentageChange ?? this.profitPercentageChange,
        ordersFromTimeFrame: orderCountStats ?? ordersFromTimeFrame,
        saleFromTimeFrame: profitStats ?? saleFromTimeFrame,
        costFromTimeFrame: costFromTimeFrame ?? this.costFromTimeFrame,
        profitFromTimeFrame: profitFromTimeFrame ?? this.profitFromTimeFrame,
        currentAdsReport: currentAdsReport ?? this.currentAdsReport,
        previousAdsReport: previousAdsReport ?? this.previousAdsReport,
        stats: stats ?? this.stats,
        selectedDate: selectedDate ?? this.selectedDate,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
