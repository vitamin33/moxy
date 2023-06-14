import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/constant/order_constants.dart';
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
class NetworkOrder {
  @JsonKey(name: '_id')
  String id;
  int ukrPostNumber;
  DeliveryType deliveryType;
  String status;
  PaymentType paymentType;
  NetworkClient client;
  List<NetworkProduct> products;
  String createdAt;
  String updatedAt;

  NetworkOrder(
      {required this.id,
      required this.ukrPostNumber,
      required this.deliveryType,
      required this.status,
      required this.paymentType,
      required this.client,
      required this.products,
      required this.createdAt,
      required this.updatedAt});

  factory NetworkOrder.fromJson(Map<String, dynamic> json) =>
      _$NetworkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkOrderToJson(this);
}

@JsonSerializable()
class NetworkClient {
  int mobileNumber;
  String firstName;
  String secondName;
  String city;
  NetworkClient(this.city, this.firstName, this.mobileNumber, this.secondName);

  factory NetworkClient.fromJson(Map<String, dynamic> json) =>
      _$NetworkClientFromJson(json);
}
