// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProduct _$CreateProductFromJson(Map<String, dynamic> json) =>
    CreateProduct(
      name: json['name'] as String,
      description: json['description'] as String,
      costPrice: json['costPrice'] as int,
      regularPrice: (json['regularPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      color: json['color'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CreateProductToJson(CreateProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'costPrice': instance.costPrice,
      'regularPrice': instance.regularPrice,
      'salePrice': instance.salePrice,
      'color': instance.color,
      'image': instance.image,
    };
