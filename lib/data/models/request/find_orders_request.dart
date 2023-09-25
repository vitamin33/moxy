import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_orders_request.g.dart';

@JsonSerializable()
class FindOrders {
  final List<String> statuses;
  final List<String> paymentTypes;
  final List<String> deliveryTypes;
  String? fromDate;
  String? toDate;

  FindOrders({
    required this.statuses,
    required this.paymentTypes,
    required this.deliveryTypes,
    this.fromDate,
    this.toDate,
  });

  factory FindOrders.fromJson(Map<String, dynamic> json) =>
      _$FindOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$FindOrdersToJson(this);
}
