// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkProductsStats _$NetworkProductsStatsFromJson(
        Map<String, dynamic> json) =>
    NetworkProductsStats(
      productStats: NetworkProductStats.fromJson(
          json['productStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkProductsStatsToJson(
        NetworkProductsStats instance) =>
    <String, dynamic>{
      'productStats': instance.productStats,
    };

NetworkProductStats _$NetworkProductStatsFromJson(Map<String, dynamic> json) =>
    NetworkProductStats(
      orderStats: (json['orderStats'] as List<dynamic>)
          .map((e) =>
              NetworkProductOrderCountStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      profitStats: (json['profitStats'] as List<dynamic>)
          .map((e) =>
              NetworkProductProfitStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkProductStatsToJson(
        NetworkProductStats instance) =>
    <String, dynamic>{
      'orderStats': instance.orderStats,
      'profitStats': instance.profitStats,
    };

NetworkProductOrderCountStat _$NetworkProductOrderCountStatFromJson(
        Map<String, dynamic> json) =>
    NetworkProductOrderCountStat(
      orderCount: json['orderCount'] as int,
      percentageFromAllOrdersCount:
          (json['percentageFromAllOrdersCount'] as num).toDouble(),
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkProductOrderCountStatToJson(
        NetworkProductOrderCountStat instance) =>
    <String, dynamic>{
      'orderCount': instance.orderCount,
      'percentageFromAllOrdersCount': instance.percentageFromAllOrdersCount,
      'product': instance.product,
    };

NetworkProductProfitStat _$NetworkProductProfitStatFromJson(
        Map<String, dynamic> json) =>
    NetworkProductProfitStat(
      profit: json['profit'] as int,
      percentageFromAllProfit:
          (json['percentageFromAllProfit'] as num).toDouble(),
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkProductProfitStatToJson(
        NetworkProductProfitStat instance) =>
    <String, dynamic>{
      'profit': instance.profit,
      'percentageFromAllProfit': instance.percentageFromAllProfit,
      'product': instance.product,
    };
