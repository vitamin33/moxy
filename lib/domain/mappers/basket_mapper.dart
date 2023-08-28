import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/services/get_it.dart';

class BasketMapper {
  final productMapper = locate<ProductMapper>();

  Basket mapToUser(NetworkBasket network) {
    return Basket(
      client: network.client,
      basketItems: network.basketItems
          .map(
            (e) => BasketItem(
              product: productMapper.mapToProduct(e.product),
              dimension: productMapper.mapToDimension(e.dimension),
            ),
          )
          .toList(),
    );
  }
}
