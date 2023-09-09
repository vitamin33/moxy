import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class Basket implements Copyable<Basket> {
  String client;
  List<BasketItem> basketItems;
  int freeShippingThreshold;

  Basket({
    required this.client,
    required this.basketItems,
    required this.freeShippingThreshold,
  });

  static Basket defaultBasket() {
    return Basket(
      client: '',
      basketItems: [],
      freeShippingThreshold: 2000,
    );
  }

  @override
  Basket copyWith({
    String? client,
    List<BasketItem>? basketItems,
    int? freeShippingThreshold,
  }) {
    return Basket(
      client: client ?? this.client,
      basketItems: basketItems ?? this.basketItems,
      freeShippingThreshold:
          freeShippingThreshold ?? this.freeShippingThreshold,
    );
  }

  int totalValue() {
    double result = 0;
    for (var element in basketItems) {
      result += element.product.salePrice * element.dimension.quantity;
    }
    return result.toInt();
  }

  int amountForFreeShipping() {
    if (freeShippingThreshold > totalValue()) {
      return freeShippingThreshold - totalValue();
    } else {
      return 0;
    }
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
