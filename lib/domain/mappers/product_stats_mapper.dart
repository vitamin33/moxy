import 'package:moxy/data/models/response/products_stats_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product_stats.dart';
import 'package:moxy/services/get_it.dart';

class ProductStatsMapper {
  final ProductMapper mapper = locate<ProductMapper>();

  ProductStats mapToProductStats(NetworkProductStats network) {
    return ProductStats(
      orderStats:
          network.orderStats.map((e) => mapToProductOrderStat(e)).toList(),
      profitStats:
          network.profitStats.map((e) => mapToProductProfitStat(e)).toList(),
    );
  }

  ProductOrderCountStat mapToProductOrderStat(
      NetworkProductOrderCountStat network) {
    return ProductOrderCountStat(
      orderCount: network.orderCount,
      percentageFromAllOrdersCount: network.percentageFromAllOrdersCount,
      product: mapper.mapToProduct(network.product),
    );
  }

  ProductProfitStat mapToProductProfitStat(NetworkProductProfitStat network) {
    return ProductProfitStat(
      profit: network.profit,
      percentageFromAllProfit: network.percentageFromAllProfit,
      product: mapper.mapToProduct(network.product),
    );
  }
}
