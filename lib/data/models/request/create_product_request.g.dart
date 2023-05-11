// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProduct _$CreateProductFromJson(Map<String, dynamic> json) =>
    CreateProduct(
      name: json['name'] as String,
      description: json['description'] as String,
      costPrice: (json['costPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      idName: json['idName'] as String,
    );

Map<String, dynamic> _$CreateProductToJson(CreateProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'costPrice': instance.costPrice,
      'salePrice': instance.salePrice,
      'dimensions': instance.dimensions,
      'images': instance.images,
      'idName': instance.idName,
    };

NetworkDimension _$NetworkDimensionFromJson(Map<String, dynamic> json) =>
    NetworkDimension(
      color: json['color'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$NetworkDimensionToJson(NetworkDimension instance) =>
    <String, dynamic>{
      'color': instance.color,
      'quantity': instance.quantity,
    };
