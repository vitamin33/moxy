// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersResponse _$AllOrdersResponseFromJson(Map<String, dynamic> json) =>
    AllOrdersResponse(
      (json['allOrder'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrdersResponseToJson(AllOrdersResponse instance) =>
    <String, dynamic>{
      'allOrder': instance.allOrder,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      ukrPostNumber: json['ukrPostNumber'] as int,
      deliveryType: json['deliveryType'] as String,
      status: json['status'] as String,
      paymentType: json['paymentType'] as String,
      client: json['client'] as String,
      products: json['products'] as List<dynamic>,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'ukrPostNumber': instance.ukrPostNumber,
      'deliveryType': instance.deliveryType,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'client': instance.client,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
