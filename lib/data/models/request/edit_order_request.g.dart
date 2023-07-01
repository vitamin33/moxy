// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditOrder _$EditOrderFromJson(Map<String, dynamic> json) => EditOrder(
      orderId: json['orderId'] as String,
      deliveryType: json['deliveryType'] as String,
      paymentType: json['paymentType'] as String,
      novaPost:
          NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => NetworkOrderedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      city: NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      status: json['status'] as String,
      cashAdvanceValue: json['cashAdvanceValue'] as int,
    );

Map<String, dynamic> _$EditOrderToJson(EditOrder instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'deliveryType': instance.deliveryType,
      'paymentType': instance.paymentType,
      'novaPost': instance.novaPost,
      'products': instance.products,
      'client': instance.client,
      'city': instance.city,
      'status': instance.status,
      'cashAdvanceValue': instance.cashAdvanceValue,
    };
