import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/domain/models/city.dart';

part 'all_orders_response.g.dart';

@JsonSerializable()
class AllOrdersResponse {
  List<NetworkOrder>? allOrder;

  AllOrdersResponse(this.allOrder);

  factory AllOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllOrdersResponseToJson(this);
}

@JsonSerializable()
class NetworkOrder {
  @JsonKey(name: '_id')
  String id;
  int cashAdvanceValue;
  NetworkNovaPost novaPost;
  NetworkCity city;
  String deliveryType;
  String status;
  String paymentType;
  CreateNetworkClient client;
  List<NetworkOrderedItemResponse> orderedItems;
  String createdAt;
  String updatedAt;

  NetworkOrder({
    required this.id,
    required this.cashAdvanceValue,
    required this.novaPost,
    required this.city,
    required this.deliveryType,
    required this.status,
    required this.paymentType,
    required this.client,
    required this.orderedItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NetworkOrder.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderFromJson(json);

  get ukrPostNumber => null;

  Map<String, dynamic> toJson() => _$NetworkOrderToJson(this);
}

@JsonSerializable()
class CreateNetworkClient {
  @JsonKey(name: '_id')
  String? id;
  String mobileNumber;
  String firstName;
  String secondName;
  String city;
  List<String> orders;
  CreateNetworkClient(this.id, this.city, this.firstName, this.mobileNumber,
      this.secondName, this.orders);

  factory CreateNetworkClient.fromJson(Map<String, dynamic> json) =>
      _$CreateNetworkClientFromJson(json);
  Map<String, dynamic> toJson() => _$CreateNetworkClientToJson(this);
}

@JsonSerializable()
class NetworkClient {
  @JsonKey(name: '_id')
  String? id;
  String mobileNumber;
  String firstName;
  String secondName;
  String city;
  NetworkClient(
      {this.id,
      required this.city,
      required this.firstName,
      required this.mobileNumber,
      required this.secondName});

  factory NetworkClient.fromJson(Map<String, dynamic> json) =>
      _$NetworkClientFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkClientToJson(this);
}

@JsonSerializable()
class NetworkOrderedItemResponse {
  String product;
  String productName;
  String imageUrl;
  List<NetworkDimension> dimensions;
  NetworkOrderedItemResponse(
      this.product, this.productName, this.dimensions, this.imageUrl);

  factory NetworkOrderedItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderedItemResponseFromJson(json);
}
