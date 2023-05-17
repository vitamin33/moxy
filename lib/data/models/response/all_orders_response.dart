import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'all_orders_response.g.dart';

@JsonSerializable()
class AllOrdersResponse {
  List<Order>? allOrder;

  AllOrdersResponse(this.allOrder);

  factory AllOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllOrdersResponseToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  String id;
  int ukrPostNumber;
  String deliveryType;
  String status;
  String paymentType;
  String client;
  List<dynamic> products;
  String createdAt;
  String updatedAt;

  Order({
    required this.id,
    required this.ukrPostNumber,
    required this.deliveryType,
    required this.status,
    required this.paymentType,
    required this.client,
    required this.products,
    required this.createdAt,
    required this.updatedAt
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
