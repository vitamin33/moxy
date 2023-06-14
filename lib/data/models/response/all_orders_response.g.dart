// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersResponse _$AllOrdersResponseFromJson(Map<String, dynamic> json) =>
    AllOrdersResponse(
      (json['allOrder'] as List<dynamic>?)
          ?.map((e) => NetworkOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrdersResponseToJson(AllOrdersResponse instance) =>
    <String, dynamic>{
      'allOrder': instance.allOrder,
    };

NetworkOrder _$NetworkOrderFromJson(Map<String, dynamic> json) => NetworkOrder(
      id: json['_id'] as String,
      ukrPostNumber: json['ukrPostNumber'] as int,
      deliveryType: $enumDecode(_$DeliveryTypeEnumMap, json['deliveryType']),
      status: json['status'] as String,
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => NetworkProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$NetworkOrderToJson(NetworkOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ukrPostNumber': instance.ukrPostNumber,
      'deliveryType': _$DeliveryTypeEnumMap[instance.deliveryType]!,
      'status': instance.status,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType]!,
      'client': instance.client,
      'products': instance.products,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$DeliveryTypeEnumMap = {
  DeliveryType.NovaPost: 'NovaPost',
  DeliveryType.UkrPost: 'UkrPost',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CashAdvance: 'CashAdvance',
  PaymentType.FullPayment: 'FullPayment',
};

NetworkClient _$NetworkClientFromJson(Map<String, dynamic> json) =>
    NetworkClient(
      json['city'] as String,
      json['firstName'] as String,
      json['mobileNumber'] as int,
      json['secondName'] as String,
    );

Map<String, dynamic> _$NetworkClientToJson(NetworkClient instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'city': instance.city,
    };
