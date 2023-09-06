import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/get_it.dart';

class BasketMapper {
  final productMapper = locate<ProductMapper>();

  Basket mapToBasket(NetworkBasket network) {
    List<BasketItem> items = [];
    for (NetworkBasketItem item in network.basketItems) {
      if (item.dimensions.length > 1) {
        for (NetworkDimension dimen in item.dimensions) {
          Dimension toAdd = productMapper.mapToDimension(dimen);
          items.add(
            BasketItem(
                product: productMapper.mapToProduct(item.product),
                dimension: toAdd),
          );
        }
      } else {
        Dimension toAdd = productMapper.mapToDimension(item.dimensions[0]);
        items.add(
          BasketItem(
              product: productMapper.mapToProduct(item.product),
              dimension: toAdd),
        );
      }
    }
    return Basket(client: network.client, basketItems: items);
  }
}
