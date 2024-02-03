// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkBasket _$NetworkBasketFromJson(Map<String, dynamic> json) =>
    NetworkBasket(
      id: json['_id'] as String,
      client: json['client'] == null
          ? null
          : NetworkProfileUser.fromJson(json['client'] as Map<String, dynamic>),
      basketItems: (json['basketItems'] as List<dynamic>)
          .map((e) => NetworkBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      freeShippingThreshold: json['freeShippingThreshold'] as int,
    );

Map<String, dynamic> _$NetworkBasketToJson(NetworkBasket instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'client': instance.client,
      'basketItems': instance.basketItems,
      'freeShippingThreshold': instance.freeShippingThreshold,
    };

NetworkBasketItem _$NetworkBasketItemFromJson(Map<String, dynamic> json) =>
    NetworkBasketItem(
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkBasketItemToJson(NetworkBasketItem instance) =>
    <String, dynamic>{
      'product': instance.product,
      'dimensions': instance.dimensions,
    };
