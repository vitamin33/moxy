// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_basket_dimen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkAddOrChange _$NetworkAddOrChangeFromJson(Map<String, dynamic> json) =>
    NetworkAddOrChange(
      product: NetworkChangeBasketDimen.fromJson(
          json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkAddOrChangeToJson(NetworkAddOrChange instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

NetworkChangeBasketDimen _$NetworkChangeBasketDimenFromJson(
        Map<String, dynamic> json) =>
    NetworkChangeBasketDimen(
      productId: json['productId'] as String,
      dimension:
          NetworkDimension.fromJson(json['dimension'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkChangeBasketDimenToJson(
        NetworkChangeBasketDimen instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'dimension': instance.dimension,
    };

NetworkRemoveProduct _$NetworkRemoveProductFromJson(
        Map<String, dynamic> json) =>
    NetworkRemoveProduct(
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$NetworkRemoveProductToJson(
        NetworkRemoveProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
    };
