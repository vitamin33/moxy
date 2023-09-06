import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class Basket implements Copyable<Basket> {
  String client;
  List<BasketItem> basketItems;

  Basket({
    required this.client,
    required this.basketItems,
  });

  static Basket defaultBasket() {
    return Basket(
      client: '',
      basketItems: [],
    );
  }

  @override
  Basket copyWith({
    String? client,
    List<BasketItem>? basketItems,
  }) {
    return Basket(
      client: client ?? this.client,
      basketItems: basketItems ?? this.basketItems,
    );
  }

  int totalValue() {
    double result = 0;
    for (var element in basketItems) {
      result += element.product.salePrice * element.dimension.quantity;
    }
    return result.toInt();
  }
}

class BasketItem implements Copyable<BasketItem> {
  Product product;
  Dimension dimension;

  BasketItem({
    required this.product,
    required this.dimension,
  });

  static BasketItem defaultBasket() {
    return BasketItem(
      product: Product.defaultProduct(),
      dimension: Dimension.defaultDimension(),
    );
  }

  @override
  BasketItem copyWith({
    Product? product,
    Dimension? dimension,
  }) {
    return BasketItem(
      product: product ?? this.product,
      dimension: dimension ?? this.dimension,
    );
  }
}
