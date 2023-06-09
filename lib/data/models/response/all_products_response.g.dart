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
      costPrice: (json['costPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      idName: json['idName'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NetworkProductToJson(NetworkProduct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'costPrice': instance.costPrice,
      'salePrice': instance.salePrice,
      'dimensions': instance.dimensions,
      'images': instance.images,
      'idName': instance.idName,
    };
