// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_orders_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindOrders _$FindOrdersFromJson(Map<String, dynamic> json) => FindOrders(
      statuses:
          (json['statuses'] as List<dynamic>).map((e) => e as String).toList(),
      paymentTypes: (json['paymentTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deliveryTypes: (json['deliveryTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
    );

Map<String, dynamic> _$FindOrdersToJson(FindOrders instance) =>
    <String, dynamic>{
      'statuses': instance.statuses,
      'paymentTypes': instance.paymentTypes,
      'deliveryTypes': instance.deliveryTypes,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
