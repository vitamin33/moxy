import 'package:moxy/domain/models/product.dart';

class ProductStats {
  List<ProductOrderCountStat> orderStats;
  List<ProductProfitStat> profitStats;

  ProductStats({required this.orderStats, required this.profitStats});

  factory ProductStats.defaultReport() {
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
  int orderCount;
  double percentageFromAllOrdersCount;
  Product product;

  ProductProfitStat({
    required this.orderCount,
    required this.percentageFromAllOrdersCount,
    required this.product,
  });
}
