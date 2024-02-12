// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkProductsStats _$NetworkProductsStatsFromJson(
        Map<String, dynamic> json) =>
    NetworkProductsStats(
      productStats:
          ProductStats.fromJson(json['productStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkProductsStatsToJson(
        NetworkProductsStats instance) =>
    <String, dynamic>{
      'productStats': instance.productStats,
    };

ProductStats _$ProductStatsFromJson(Map<String, dynamic> json) => ProductStats(
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: DateTime.parse(json['toDate'] as String),
    );

Map<String, dynamic> _$ProductStatsToJson(ProductStats instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate.toIso8601String(),
      'toDate': instance.toDate.toIso8601String(),
    };

ProductOrderCountStat _$ProductOrderCountStatFromJson(
        Map<String, dynamic> json) =>
    ProductOrderCountStat(
      orderCount: json['orderCount'] as int,
      percentageFromAllOrdersCount:
          (json['percentageFromAllOrdersCount'] as num).toDouble(),
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductOrderCountStatToJson(
        ProductOrderCountStat instance) =>
    <String, dynamic>{
      'orderCount': instance.orderCount,
      'percentageFromAllOrdersCount': instance.percentageFromAllOrdersCount,
      'product': instance.product,
    };

ProductProfitStat _$ProductProfitStatFromJson(Map<String, dynamic> json) =>
    ProductProfitStat(
      orderCount: json['orderCount'] as int,
      percentageFromAllOrdersCount:
          (json['percentageFromAllOrdersCount'] as num).toDouble(),
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductProfitStatToJson(ProductProfitStat instance) =>
    <String, dynamic>{
      'orderCount': instance.orderCount,
      'percentageFromAllOrdersCount': instance.percentageFromAllOrdersCount,
      'product': instance.product,
    };
