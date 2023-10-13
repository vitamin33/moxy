// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProduct _$CreateProductFromJson(Map<String, dynamic> json) =>
    CreateProduct(
      name: json['name'] as String,
      description: json['description'] as String,
      costPriceInUsd: (json['costPriceInUsd'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      idName: json['idName'] as String,
    );

Map<String, dynamic> _$CreateProductToJson(CreateProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'costPriceInUsd': instance.costPriceInUsd,
      'salePrice': instance.salePrice,
      'idName': instance.idName,
    };

NetworkDimension _$NetworkDimensionFromJson(Map<String, dynamic> json) =>
    NetworkDimension(
      color: NetworkColor.fromJson(json['color'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : NetworkSize.fromJson(json['size'] as Map<String, dynamic>),
      material: json['material'] == null
          ? null
          : NetworkMaterial.fromJson(json['material'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NetworkDimensionToJson(NetworkDimension instance) =>
    <String, dynamic>{
      'color': instance.color,
      'size': instance.size,
      'material': instance.material,
      'quantity': instance.quantity,
      'images': instance.images,
    };

NetworkColor _$NetworkColorFromJson(Map<String, dynamic> json) => NetworkColor(
      id: json['_id'] as String,
      name: json['name'] as String,
      hexCode: json['hexCode'] as String,
    );

Map<String, dynamic> _$NetworkColorToJson(NetworkColor instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'hexCode': instance.hexCode,
    };

NetworkSize _$NetworkSizeFromJson(Map<String, dynamic> json) => NetworkSize(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NetworkSizeToJson(NetworkSize instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

NetworkMaterial _$NetworkMaterialFromJson(Map<String, dynamic> json) =>
    NetworkMaterial(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NetworkMaterialToJson(NetworkMaterial instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

NetworkProductAttributes _$NetworkProductAttributesFromJson(
        Map<String, dynamic> json) =>
    NetworkProductAttributes(
      weightInGrams: json['weightInGrams'] as int,
      heightInCm: json['heightInCm'] as int,
      widthInCm: json['widthInCm'] as int,
      lengthInCm: json['lengthInCm'] as int,
      season: json['season'] as String?,
      furniture: json['furniture'] as String?,
      depthInCm: json['depthInCm'] as int?,
      producer: json['producer'] as String?,
      strap: json['strap'] as String?,
      style: json['style'] as String?,
    );

Map<String, dynamic> _$NetworkProductAttributesToJson(
        NetworkProductAttributes instance) =>
    <String, dynamic>{
      'season': instance.season,
      'weightInGrams': instance.weightInGrams,
      'furniture': instance.furniture,
      'strap': instance.strap,
      'heightInCm': instance.heightInCm,
      'widthInCm': instance.widthInCm,
      'lengthInCm': instance.lengthInCm,
      'depthInCm': instance.depthInCm,
      'producer': instance.producer,
      'style': instance.style,
    };
