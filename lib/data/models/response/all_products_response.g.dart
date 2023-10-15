// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllProductsResponse _$AllProductsResponseFromJson(Map<String, dynamic> json) =>
    AllProductsResponse(
      (json['allProducts'] as List<dynamic>?)
          ?.map((e) => NetworkProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllProductsResponseToJson(
        AllProductsResponse instance) =>
    <String, dynamic>{
      'allProducts': instance.allProducts,
    };

NetworkProduct _$NetworkProductFromJson(Map<String, dynamic> json) =>
    NetworkProduct(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      costPriceInUsd: (json['costPriceInUsd'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      dimensions: (json['dimensions'] as List<dynamic>?)
          ?.map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      idName: json['idName'] as String,
      category: json['category'] as String,
      forSale: json['forSale'] as bool,
      attributes: NetworkProductAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkProductToJson(NetworkProduct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'costPriceInUsd': instance.costPriceInUsd,
      'discountPrice': instance.discountPrice,
      'costPrice': instance.costPrice,
      'salePrice': instance.salePrice,
      'dimensions': instance.dimensions,
      'idName': instance.idName,
      'category': instance.category,
      'forSale': instance.forSale,
      'attributes': instance.attributes,
    };
