import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/data/models/response/products_stats_response.dart';
import 'package:moxy/domain/models/product_stats.dart';

import '../models/city.dart';

class ProductStatsMapper {
  ProductStats mapToProductStats(NetworkProductsStats network) {
    return networkCities
        .map(
          (e) => City(
            mainDescription: e.mainDescription,
            ref: e.ref,
            deliveryCityRef: e.deliveryCityRef,
            presentName: e.presentName,
          ),
        )
        .toList();
  }

  ProductOrderCountStat mapToProductOrderStat(ProductOrderCountStat network) {
    if (city == null) {
      return null;
    }
    return NetworkCity(
      ref: city.ref,
      mainDescription: city.mainDescription,
      deliveryCityRef: city.deliveryCityRef,
      presentName: city.presentName,
    );
  }

  City? mapToCity(NetworkCity? city) {
    if (city == null) {
      return null;
    }
    return City(
      mainDescription: city.mainDescription!,
      ref: city.ref!,
      deliveryCityRef: city.deliveryCityRef!,
      presentName: city.presentName!,
    );
  }
}
