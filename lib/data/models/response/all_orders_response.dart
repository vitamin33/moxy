import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

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
class ProfileOrdersResponse {
  List<NetworkProfileOrder>? profileOrders;

  ProfileOrdersResponse(this.profileOrders);

  factory ProfileOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileOrdersResponseToJson(this);
}

@JsonSerializable()
class NetworkProfileOrderItem {
  String product;
  List<NetworkDimension> dimensions;
  NetworkProfileOrderItem(
    this.product,
    this.dimensions,
  );

  factory NetworkProfileOrderItem.fromJson(Map<String, dynamic> json) =>
      _$NetworkProfileOrderItemFromJson(json);
}

@JsonSerializable()
class NetworkOrder {
  @JsonKey(name: '_id')
  String? id;
  int cashAdvanceValue;
  NetworkNovaPost? novaPost;
  NetworkCity? city;
  String deliveryType;
  String status;
  String paymentType;
  CreateNetworkClient client;
  List<NetworkOrderedItemResponse> orderedItems;
  String createdAt;
  String updatedAt;

  NetworkOrder({
    this.id,
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
class NetworkProfileOrder {
  @JsonKey(name: '_id')
  String? id;
  int cashAdvanceValue;
  NetworkNovaPost? novaPost;
  NetworkCity? city;
  String deliveryType;
  String status;
  String paymentType;
  List<NetworkOrderedItemResponse> orderedItems;
  String? client;
  String createdAt;
  String updatedAt;

  NetworkProfileOrder({
    this.id,
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

  factory NetworkProfileOrder.fromJson(Map<String, dynamic> json) =>
      _$NetworkProfileOrderFromJson(json);

  get ukrPostNumber => null;

  Map<String, dynamic> toJson() => _$NetworkProfileOrderToJson(this);
}

@JsonSerializable()
class CreateNetworkClient {
  @JsonKey(name: '_id')
  String? id;
  String mobileNumber;
  String firstName;
  String secondName;
  NetworkCity? city;
  List<String>? orders;
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
  NetworkCity? city;
  NetworkClient({
    this.id,
    required this.city,
    required this.firstName,
    required this.mobileNumber,
    required this.secondName,
  });

  factory NetworkClient.fromJson(Map<String, dynamic> json) =>
      _$NetworkClientFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkClientToJson(this);
}

@JsonSerializable()
class NetworkOrderedItemResponse {
  String product;
  String? productName;
  int? productPrice;
  List<NetworkDimension> dimensions;
  NetworkOrderedItemResponse(
      this.product, this.productName, this.dimensions, this.productPrice);

  factory NetworkOrderedItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderedItemResponseFromJson(json);
}

@JsonSerializable()
class NetworkOrderedProductResponse {
  NetworkProduct product;
  List<NetworkDimension> dimensions;
  NetworkOrderedProductResponse(
    this.product,
    this.dimensions,
  );

  factory NetworkOrderedProductResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderedProductResponseFromJson(json);
}
