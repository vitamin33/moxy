import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';

import '../../../constant/order_constants.dart';
import '../response/all_orders_response.dart';

part 'create_order_request.g.dart';

@JsonSerializable()
class CreateOrder {
  final DeliveryType deliveryType;
  final PaymentType paymentType;
  final int novaPostNumber;
  final List<NetworkOrderedItem> products;
  final NetworkClient client;
  final String status;

  CreateOrder({
    required this.deliveryType,
    required this.paymentType,
    required this.novaPostNumber,
    required this.products,
    required this.client,
    required this.status,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderToJson(this);
}

@JsonSerializable()
class NetworkOrderedItem {
  @JsonKey(name: '_id')
  String? id;
  List<NetworkDimension> dimensions;

  NetworkOrderedItem({
    required this.id,
    required this.dimensions,
  });

  factory NetworkOrderedItem.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderedItemFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkOrderedItemToJson(this);
}
