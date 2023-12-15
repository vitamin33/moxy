// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkMedia _$NetworkMediaFromJson(Map<String, dynamic> json) => NetworkMedia(
      id: json['_id'] as String,
      type: json['type'] as String,
      mediaUrls:
          (json['mediaUrls'] as List<dynamic>).map((e) => e as String).toList(),
      activeHome: json['activeHome'] as bool,
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$NetworkMediaToJson(NetworkMedia instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'mediaUrls': instance.mediaUrls,
      'activeHome': instance.activeHome,
      'productId': instance.productId,
    };
