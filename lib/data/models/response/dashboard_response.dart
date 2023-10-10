import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class NetworkDashboard {
  int totalSaleValue;
  int totalCostValue;
  int totalOrdersCount;
  int totalProfitValue;
  int previousTotalSaleValue;
  int previousTotalCostValue;
  int previousTotalProfitValue;
  int previousTotalOrdersCount;
  double saleValuePercentageChange;
  double costValuePercentageChange;
  double ordersCountPercentageChange;
  double profitValuePercentageChange;
  List<TotalByTimeFrame> ordersCountByTimeFrame;
  List<TotalByTimeFrame> totalSaleValueByTimeFrame;
  List<TotalByTimeFrame> totalCostValueByTimeFrame;
  List<TotalByTimeFrame> totalProfitValueByTimeFrame;

  NetworkDashboard({
    required this.totalSaleValue,
    required this.totalCostValue,
    required this.totalOrdersCount,
    required this.totalProfitValue,
    required this.previousTotalSaleValue,
    required this.previousTotalCostValue,
    required this.previousTotalOrdersCount,
    required this.previousTotalProfitValue,
    required this.saleValuePercentageChange,
    required this.costValuePercentageChange,
    required this.ordersCountPercentageChange,
    required this.profitValuePercentageChange,
    required this.ordersCountByTimeFrame,
    required this.totalSaleValueByTimeFrame,
    required this.totalCostValueByTimeFrame,
    required this.totalProfitValueByTimeFrame,
  });

  factory NetworkDashboard.fromJson(Map<String, dynamic> json) =>
      _$NetworkDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkDashboardToJson(this);
}

@JsonSerializable()
class TotalByTimeFrame {
  DateTime fromDate;
  DateTime toDate;
  String key;
  int value;

  TotalByTimeFrame(
      {required this.fromDate,
      required this.toDate,
      required this.key,
      required this.value});
  factory TotalByTimeFrame.fromJson(Map<String, dynamic> json) =>
      _$TotalByTimeFrameFromJson(json);

  Map<String, dynamic> toJson() => _$TotalByTimeFrameToJson(this);
}
