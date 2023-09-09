import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'basket_response.g.dart';

@JsonSerializable()
class NetworkBasket {
  String client;
  List<NetworkBasketItem> basketItems;
  int freeShippingThreshold;

  NetworkBasket({
    required this.client,
    required this.basketItems,
    required this.freeShippingThreshold,
  });

  factory NetworkBasket.fromJson(Map<String, dynamic> json) =>
      _$NetworkBasketFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkBasketToJson(this);
}

@JsonSerializable()
class NetworkBasketItem {
  NetworkProduct product;
  List<NetworkDimension> dimensions;

  NetworkBasketItem({
    required this.product,
    required this.dimensions,
  });
  factory NetworkBasketItem.fromJson(Map<String, dynamic> json) =>
      _$NetworkBasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkBasketItemToJson(this);
}
