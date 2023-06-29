import 'package:json_annotation/json_annotation.dart';

import '../../../constant/order_constants.dart';
import '../response/all_orders_response.dart';
import 'create_order_request.dart';
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
