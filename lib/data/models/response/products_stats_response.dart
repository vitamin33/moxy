import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'products_stats_response.g.dart';

@JsonSerializable()
class NetworkProductsStats {
  ProductStats productStats;

  NetworkProductsStats({
    required this.productStats,
  });

  factory NetworkProductsStats.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductsStatsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductsStatsToJson(this);
}

@JsonSerializable()
class ProductStats {
  List<ProductOrderCountStat> orderStats;
  List<ProductProfitStat> profitStats;

  ProductStats({
    required this.orderStats,
    required this.profitStats,
  });
  factory ProductStats.fromJson(Map<String, dynamic> json) =>
      _$ProductStatsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStatsToJson(this);
}

@JsonSerializable()
class ProductOrderCountStat {
  int orderCount;
  double percentageFromAllOrdersCount;
  NetworkProduct product;

  ProductOrderCountStat({
    required this.orderCount,
    required this.percentageFromAllOrdersCount,
    required this.product,
  });
  factory ProductOrderCountStat.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderCountStatFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOrderCountStatToJson(this);
}

@JsonSerializable()
class ProductProfitStat {
  int orderCount;
  double percentageFromAllOrdersCount;
  NetworkProduct product;

  ProductProfitStat({
    required this.orderCount,
    required this.percentageFromAllOrdersCount,
    required this.product,
  });
  factory ProductProfitStat.fromJson(Map<String, dynamic> json) =>
      _$ProductProfitStatFromJson(json);

  Map<String, dynamic> toJson() => _$ProductProfitStatToJson(this);
}
