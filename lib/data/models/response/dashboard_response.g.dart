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
      'ordersCountByTimeFrame': instance.ordersCountByTimeFrame,
      'totalSaleValueByTimeFrame': instance.totalSaleValueByTimeFrame,
      'totalCostValueByTimeFrame': instance.totalCostValueByTimeFrame,
    };

TotalByTimeFrame _$TotalByTimeFrameFromJson(Map<String, dynamic> json) =>
    TotalByTimeFrame(
      date: DateTime.parse(json['date'] as String),
      value: json['value'] as int,
    );

Map<String, dynamic> _$TotalByTimeFrameToJson(TotalByTimeFrame instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'value': instance.value,
    };
