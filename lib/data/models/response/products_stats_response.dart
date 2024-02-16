import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'products_stats_response.g.dart';

@JsonSerializable()
class NetworkProductsStats {
  NetworkProductStats productStats;

  NetworkProductsStats({
    required this.productStats,
  });

  factory NetworkProductsStats.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductsStatsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductsStatsToJson(this);
}

@JsonSerializable()
class NetworkProductStats {
  List<NetworkProductOrderCountStat> orderStats;
  List<NetworkProductProfitStat> profitStats;

  NetworkProductStats({
    required this.orderStats,
    required this.profitStats,
  });
  factory NetworkProductStats.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductStatsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductStatsToJson(this);
}

@JsonSerializable()
class NetworkProductOrderCountStat {
  int orderCount;
  double percentageFromAllOrdersCount;
  NetworkProduct product;

  NetworkProductOrderCountStat({
    required this.orderCount,
    required this.percentageFromAllOrdersCount,
    required this.product,
  });
  factory NetworkProductOrderCountStat.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductOrderCountStatFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductOrderCountStatToJson(this);
}

@JsonSerializable()
class NetworkProductProfitStat {
  int profit;
  double percentageFromAllProfit;
  NetworkProduct product;

  NetworkProductProfitStat({
    required this.profit,
    required this.percentageFromAllProfit,
    required this.product,
  });
  factory NetworkProductProfitStat.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductProfitStatFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductProfitStatToJson(this);
}
