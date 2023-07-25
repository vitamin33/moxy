import 'package:flutter/material.dart';
import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  final bool isLoading;
  final int totalSale;
  final int totalCost;
  final int totalOrders;
  final String errorMessage;
  final DateTimeRange? selectedDate;

  DashboardState(
      {required this.isLoading,
      required this.totalSale,
      required this.totalCost,
      required this.totalOrders,
      required this.errorMessage,
      this.selectedDate});

  static defaultDashboardState() {
    return DashboardState(
        totalSale: 0,
        totalCost: 0,
        totalOrders: 0,
        selectedDate: null,
        isLoading: false,
        errorMessage: '');
  }

  @override
  DashboardState copyWith(
      {bool? isLoading,
      String? errorMessage,
      int? totalSale,
      int? totalCost,
      int? totalOrders,
      DateTimeRange? selectedDate}) {
    return DashboardState(
        totalSale: totalSale ?? this.totalSale,
        isLoading: isLoading ?? this.isLoading,
        totalCost: totalCost ?? this.totalCost,
        totalOrders: totalOrders ?? this.totalOrders,
        selectedDate: selectedDate ?? this.selectedDate,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
