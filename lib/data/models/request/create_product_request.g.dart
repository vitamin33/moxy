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
      warehouseQuantity: json['warehouseQuantity'] as int,
      salePrice: (json['salePrice'] as num).toDouble(),
      color: json['color'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateProductToJson(CreateProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'warehouseQuantity': instance.warehouseQuantity,
      'costPrice': instance.costPrice,
      'salePrice': instance.salePrice,
      'color': instance.color,
      'images': instance.images,
    };