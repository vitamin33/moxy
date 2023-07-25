import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class NetworkDashboard {
  int totalSaleValue;
  int totalCostValue;
  int totalOrdersCount;
  List<TotalByTimeFrame> ordersCountByTimeFrame;
  List<TotalByTimeFrame> totalSaleValueByTimeFrame;
  List<TotalByTimeFrame> totalCostValueByTimeFrame;

  NetworkDashboard({
    required this.totalSaleValue,
    required this.totalCostValue,
    required this.totalOrdersCount,
    required this.ordersCountByTimeFrame,
    required this.totalSaleValueByTimeFrame,
    required this.totalCostValueByTimeFrame,
  });

  factory NetworkDashboard.fromJson(Map<String, dynamic> json) =>
      _$NetworkDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkDashboardToJson(this);
}

@JsonSerializable()
class TotalByTimeFrame {
  DateTime date;
  int value;

  TotalByTimeFrame({required this.date, required this.value});
  factory TotalByTimeFrame.fromJson(Map<String, dynamic> json) =>
  _$TotalByTimeFrameFromJson(json);

  Map<String, dynamic> toJson() => _$TotalByTimeFrameToJson(this);
}
