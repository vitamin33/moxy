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
      totalProfitValue: json['totalProfitValue'] as int,
      previousTotalSaleValue: json['previousTotalSaleValue'] as int,
      previousTotalCostValue: json['previousTotalCostValue'] as int,
      previousTotalOrdersCount: json['previousTotalOrdersCount'] as int,
      previousTotalProfitValue: json['previousTotalProfitValue'] as int,
      saleValuePercentageChange:
          (json['saleValuePercentageChange'] as num).toDouble(),
      costValuePercentageChange:
          (json['costValuePercentageChange'] as num).toDouble(),
      ordersCountPercentageChange:
          (json['ordersCountPercentageChange'] as num).toDouble(),
      profitValuePercentageChange:
          (json['profitValuePercentageChange'] as num).toDouble(),
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
      totalProfitValueByTimeFrame:
          (json['totalProfitValueByTimeFrame'] as List<dynamic>)
              .map((e) => TotalByTimeFrame.fromJson(e as Map<String, dynamic>))
              .toList(),
      currentAdsReport: AdsReportResponse.fromJson(
          json['currentAdsReport'] as Map<String, dynamic>),
      previousAdsReport: AdsReportResponse.fromJson(
          json['previousAdsReport'] as Map<String, dynamic>),
      kpis: KpisResponse.fromJson(json['kpis'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkDashboardToJson(NetworkDashboard instance) =>
    <String, dynamic>{
      'totalSaleValue': instance.totalSaleValue,
      'totalCostValue': instance.totalCostValue,
      'totalOrdersCount': instance.totalOrdersCount,
      'totalProfitValue': instance.totalProfitValue,
      'previousTotalSaleValue': instance.previousTotalSaleValue,
      'previousTotalCostValue': instance.previousTotalCostValue,
      'previousTotalProfitValue': instance.previousTotalProfitValue,
      'previousTotalOrdersCount': instance.previousTotalOrdersCount,
      'saleValuePercentageChange': instance.saleValuePercentageChange,
      'costValuePercentageChange': instance.costValuePercentageChange,
      'ordersCountPercentageChange': instance.ordersCountPercentageChange,
      'profitValuePercentageChange': instance.profitValuePercentageChange,
      'ordersCountByTimeFrame': instance.ordersCountByTimeFrame,
      'totalSaleValueByTimeFrame': instance.totalSaleValueByTimeFrame,
      'totalCostValueByTimeFrame': instance.totalCostValueByTimeFrame,
      'totalProfitValueByTimeFrame': instance.totalProfitValueByTimeFrame,
      'currentAdsReport': instance.currentAdsReport,
      'previousAdsReport': instance.previousAdsReport,
      'kpis': instance.kpis,
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

AdsReportResponse _$AdsReportResponseFromJson(Map<String, dynamic> json) =>
    AdsReportResponse(
      spend: json['spend'] as String,
      spendInUah: json['spendInUah'] as String,
      reach: json['reach'] as String,
      cpm: json['cpm'] as String,
      cpc: json['cpc'] as String,
      ctr: json['ctr'] as String,
    );

Map<String, dynamic> _$AdsReportResponseToJson(AdsReportResponse instance) =>
    <String, dynamic>{
      'spend': instance.spend,
      'spendInUah': instance.spendInUah,
      'reach': instance.reach,
      'cpm': instance.cpm,
      'ctr': instance.ctr,
      'cpc': instance.cpc,
    };

KpisResponse _$KpisResponseFromJson(Map<String, dynamic> json) => KpisResponse(
      avgOrderValue: json['avgOrderValue'] as String,
      avgOrderValuePrev: json['avgOrderValuePrev'] as String,
      avgOrderProfit: json['avgOrderProfit'] as String,
      avgOrderProfitPrev: json['avgOrderProfitPrev'] as String,
      ltgpToCacRatio: json['ltgpToCacRatio'] as String,
      ltgpToCacRatioPrev: json['ltgpToCacRatioPrev'] as String,
    );

Map<String, dynamic> _$KpisResponseToJson(KpisResponse instance) =>
    <String, dynamic>{
      'avgOrderValue': instance.avgOrderValue,
      'avgOrderValuePrev': instance.avgOrderValuePrev,
      'avgOrderProfit': instance.avgOrderProfit,
      'avgOrderProfitPrev': instance.avgOrderProfitPrev,
      'ltgpToCacRatio': instance.ltgpToCacRatio,
      'ltgpToCacRatioPrev': instance.ltgpToCacRatioPrev,
    };
