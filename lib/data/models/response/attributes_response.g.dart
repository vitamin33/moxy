// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkAttributesResponse _$NetworkAttributesResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkAttributesResponse(
      (json['colors'] as List<dynamic>)
          .map((e) => NetworkColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sizes'] as List<dynamic>)
          .map((e) => NetworkSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['materials'] as List<dynamic>)
          .map((e) => NetworkMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkAttributesResponseToJson(
        NetworkAttributesResponse instance) =>
    <String, dynamic>{
      'colors': instance.colors,
      'sizes': instance.sizes,
      'materials': instance.materials,
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
