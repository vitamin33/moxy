import 'package:flutter/material.dart';
import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  final String totalBalance;
  final String totalProduct;
  final DateTimeRange? selectedDate;

  DashboardState(
      {required this.totalBalance,
      required this.totalProduct,
      this.selectedDate});

  static defaultDashboardState() {
    return DashboardState(
        totalBalance: '0', totalProduct: '12', selectedDate: null);
  }

  @override
  DashboardState copyWith(
      {String? totalBalance,
      String? totalProduct,
      DateTimeRange? selectedDate}) {
    return DashboardState(
        totalBalance: this.totalBalance,
        totalProduct: this.totalProduct,
        selectedDate: selectedDate ?? this.selectedDate);
  }
}
