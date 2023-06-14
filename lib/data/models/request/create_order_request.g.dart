// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
      deliveryType: $enumDecode(_$DeliveryTypeEnumMap, json['deliveryType']),
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      novaPostNumber: json['novaPostNumber'] as int,
      products: (json['products'] as List<dynamic>)
          .map((e) => NetworkOrderedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'deliveryType': _$DeliveryTypeEnumMap[instance.deliveryType]!,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType]!,
      'novaPostNumber': instance.novaPostNumber,
      'products': instance.products,
      'client': instance.client,
      'status': instance.status,
    };

const _$DeliveryTypeEnumMap = {
  DeliveryType.novaPost: 'novaPost',
  DeliveryType.ukrPost: 'ukrPost',
};

const _$PaymentTypeEnumMap = {
  PaymentType.cashAdvance: 'cashAdvance',
  PaymentType.fullPayment: 'fullPayment',
};

NetworkOrderedItem _$NetworkOrderedItemFromJson(Map<String, dynamic> json) =>
    NetworkOrderedItem(
      id: json['_id'] as String?,
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkOrderedItemToJson(NetworkOrderedItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'dimensions': instance.dimensions,
    };
