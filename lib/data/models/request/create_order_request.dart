import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/domain/models/order.dart';

import '../../../constant/order_constants.dart';
import '../../../domain/models/product.dart';
import '../response/all_orders_response.dart';
import '../response/all_products_response.dart';

part 'create_order_request.g.dart';

@JsonSerializable()
class CreateOrder {
  final DeliveryType deliveryType;
  final PaymentType paymentType;
  final int novaPostNumber;
  final List<NetworkProduct> selectedProducts;
  final NetworkClient client;
  final String status;
 

  CreateOrder({
    required this.deliveryType,
    required this.paymentType,
    required this.novaPostNumber,
    required this.selectedProducts,
    required this.client,
    required this.status,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderToJson(this);
}



