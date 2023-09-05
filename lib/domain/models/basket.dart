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
}

class BasketItem implements Copyable<BasketItem> {
  Product product;
  List<Dimension> dimensions;

  BasketItem({
    required this.product,
    required this.dimensions,
  });

  static BasketItem defaultBasket() {
    return BasketItem(
      product: Product.defaultProduct(),
      dimensions: [],
    );
  }

  @override
  BasketItem copyWith({
    Product? product,
    List<Dimension>? dimensions,
  }) {
    return BasketItem(
      product: product ?? this.product,
      dimensions: dimensions ?? this.dimensions,
    );
  }
}
