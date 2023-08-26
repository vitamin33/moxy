// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkBasket _$NetworkBasketFromJson(Map<String, dynamic> json) =>
    NetworkBasket(
      client: json['client'] as String,
      basketItems: (json['basketItems'] as List<dynamic>)
          .map((e) => NetworkBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkBasketToJson(NetworkBasket instance) =>
    <String, dynamic>{
      'client': instance.client,
      'basketItems': instance.basketItems,
    };

NetworkBasketItem _$NetworkBasketItemFromJson(Map<String, dynamic> json) =>
    NetworkBasketItem(
      product: NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
      dimension:
          NetworkDimension.fromJson(json['dimension'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkBasketItemToJson(NetworkBasketItem instance) =>
    <String, dynamic>{
      'product': instance.product,
      'dimension': instance.dimension,
    };
