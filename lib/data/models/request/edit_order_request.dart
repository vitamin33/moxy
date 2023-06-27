import 'package:json_annotation/json_annotation.dart';

import '../response/all_orders_response.dart';
import 'create_product_request.dart';

part 'edit_order_request.g.dart';

@JsonSerializable()
class EditOrder {
  final String orderId;
  final String deliveryType;
  final String paymentType;
  final NetworkNovaPost novaPost;
  final List<NetworkOrderedItem> products;
  final NetworkClient client;
  final NetworkCity city;
  final String status;
  final int cashAdvanceValue;

  EditOrder({
    required this.orderId,
    required this.deliveryType,
    required this.paymentType,
    required this.novaPost,
    required this.products,
    required this.client,
    required this.city,
    required this.status,
    required this.cashAdvanceValue,
  });

  factory EditOrder.fromJson(Map<String, dynamic> json) =>
      _$EditOrderFromJson(json);

  Map<String, dynamic> toJson() => _$EditOrderToJson(this);
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
  String? postMachineType;
  int number;
 

  NetworkNovaPost({
    required this.ref,
     this.postMachineType,
    required this.number,
  });

  factory NetworkNovaPost.fromJson(Map<String, dynamic> json) =>
      _$NetworkNovaPostFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkNovaPostToJson(this);
}