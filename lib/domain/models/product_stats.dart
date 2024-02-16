import 'package:moxy/domain/models/product.dart';

class ProductStats {
  List<ProductOrderCountStat> orderStats;
  List<ProductProfitStat> profitStats;

  ProductStats({required this.orderStats, required this.profitStats});

  factory ProductStats.defaultStats() {
    return ProductStats(orderStats: [], profitStats: []);
  }
}

class ProductOrderCountStat {
  int orderCount;
  double percentageFromAllOrdersCount;
  Product product;

  ProductOrderCountStat({
    required this.orderCount,
    required this.percentageFromAllOrdersCount,
    required this.product,
  });
}

class ProductProfitStat {
  int profit;
  double percentageFromAllProfit;
  Product product;

  ProductProfitStat({
    required this.profit,
    required this.percentageFromAllProfit,
    required this.product,
  });
}
