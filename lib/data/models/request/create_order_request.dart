import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';

import '../../../constant/order_constants.dart';
import '../../../domain/models/city.dart';
import '../response/all_orders_response.dart';

part 'create_order_request.g.dart';

@JsonSerializable()
class CreateOrder {
  final String deliveryType;
  final String paymentType;
  final NetworkNovaPost novaPost;
  final List<NetworkOrderedItem> products;
  final NetworkClient client;
  final NetworkCity city;
  final String status;
  final int cashAdvanceValue;

  CreateOrder({
    required this.deliveryType,
    required this.paymentType,
    required this.novaPost,
    required this.products,
    required this.client,
    required this.city,
    required this.status,
    required this.cashAdvanceValue,
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

@JsonSerializable()
class NetworkCity {
  String? ref;
  String? mainDescription;
  String? deliveryCityRef;
  String? presentName;

  NetworkCity({
    required this.ref,
    required this.mainDescription,
    required this.deliveryCityRef,
    required this.presentName,
  });

  factory NetworkCity.fromJson(Map<String, dynamic> json) =>
      _$NetworkCityFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkCityToJson(this);
}

@JsonSerializable()
class NetworkNovaPost {
  String ref;
  String postMachineType;
  int number;
 

  NetworkNovaPost({
    required this.ref,
    required this.postMachineType,
    required this.number,
  });

  factory NetworkNovaPost.fromJson(Map<String, dynamic> json) =>
      _$NetworkNovaPostFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkNovaPostToJson(this);
}
