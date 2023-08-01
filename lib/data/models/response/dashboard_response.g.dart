// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkDashboard _$NetworkDashboardFromJson(Map<String, dynamic> json) =>
    NetworkDashboard(
      totalSaleValue: json['totalSaleValue'] as int,
      totalCostValue: json['totalCostValue'] as int,
      totalOrdersCount: json['totalOrdersCount'] as int,
      previousTotalSaleValue: json['previousTotalSaleValue'] as int,
      previousTotalCostValue: json['previousTotalCostValue'] as int,
      previousTotalOrdersCount: json['previousTotalOrdersCount'] as int,
      saleValuePercentageChange:
          (json['saleValuePercentageChange'] as num).toDouble(),
      costValuePercentageChange:
          (json['costValuePercentageChange'] as num).toDouble(),
      ordersCountPercentageChange:
          (json['ordersCountPercentageChange'] as num).toDouble(),
      ordersCountByTimeFrame: (json['ordersCountByTimeFrame'] as List<dynamic>)
          .map((e) => TotalByTimeFrame.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSaleValueByTimeFrame:
          (json['totalSaleValueByTimeFrame'] as List<dynamic>)
              .map((e) => TotalByTimeFrame.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalCostValueByTimeFrame:
          (json['totalCostValueByTimeFrame'] as List<dynamic>)
              .map((e) => TotalByTimeFrame.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$NetworkDashboardToJson(NetworkDashboard instance) =>
    <String, dynamic>{
      'totalSaleValue': instance.totalSaleValue,
      'totalCostValue': instance.totalCostValue,
      'totalOrdersCount': instance.totalOrdersCount,
      'previousTotalSaleValue': instance.previousTotalSaleValue,
      'previousTotalCostValue': instance.previousTotalCostValue,
      'previousTotalOrdersCount': instance.previousTotalOrdersCount,
      'saleValuePercentageChange': instance.saleValuePercentageChange,
      'costValuePercentageChange': instance.costValuePercentageChange,
      'ordersCountPercentageChange': instance.ordersCountPercentageChange,
      'ordersCountByTimeFrame': instance.ordersCountByTimeFrame,
      'totalSaleValueByTimeFrame': instance.totalSaleValueByTimeFrame,
      'totalCostValueByTimeFrame': instance.totalCostValueByTimeFrame,
    };

TotalByTimeFrame _$TotalByTimeFrameFromJson(Map<String, dynamic> json) =>
    TotalByTimeFrame(
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: DateTime.parse(json['toDate'] as String),
      key: json['key'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$TotalByTimeFrameToJson(TotalByTimeFrame instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate.toIso8601String(),
      'toDate': instance.toDate.toIso8601String(),
      'key': instance.key,
      'value': instance.value,
    };
