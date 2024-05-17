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
      costPriceInUsd: (json['costPriceInUsd'] as num?)?.toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      dimensions: (json['dimensions'] as List<dynamic>?)
          ?.map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      idName: json['idName'] as String,
      category: json['category'] as String,
      forSale: json['forSale'] as bool,
      isFavorite: json['isFavorite'] as bool?,
      attributes: NetworkProductAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
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
      'isFavorite': instance.isFavorite,
      'attributes': instance.attributes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

NetworkProductDetails _$NetworkProductDetailsFromJson(
        Map<String, dynamic> json) =>
    NetworkProductDetails(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      costPriceInUsd: (json['costPriceInUsd'] as num?)?.toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      dimensions: (json['dimensions'] as List<dynamic>?)
          ?.map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      idName: json['idName'] as String,
      category: json['category'] as String,
      forSale: json['forSale'] as bool,
      isFavorite: json['isFavorite'] as bool?,
      attributes: NetworkProductAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      productAdvantages: (json['productAdvantages'] as List<dynamic>?)
          ?.map((e) =>
              NetworkProductAdantages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkProductDetailsToJson(
        NetworkProductDetails instance) =>
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
      'isFavorite': instance.isFavorite,
      'attributes': instance.attributes,
      'productAdvantages': instance.productAdvantages,
    };

NetworkProductAdantages _$NetworkProductAdantagesFromJson(
        Map<String, dynamic> json) =>
    NetworkProductAdantages(
      header: json['header'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$NetworkProductAdantagesToJson(
        NetworkProductAdantages instance) =>
    <String, dynamic>{
      'header': instance.header,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
