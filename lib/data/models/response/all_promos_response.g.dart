// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_promos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPromosResponse _$AllPromosResponseFromJson(Map<String, dynamic> json) =>
    AllPromosResponse(
      (json['allPromos'] as List<dynamic>?)
          ?.map((e) => NetworkPromos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPromosResponseToJson(AllPromosResponse instance) =>
    <String, dynamic>{
      'allPromos': instance.allPromos,
    };

NetworkPromos _$NetworkPromosFromJson(Map<String, dynamic> json) =>
    NetworkPromos(
      id: json['_id'] as String?,
      title: json['title'] as String,
      discount: json['discount'] as int,
      productId: json['productId'] as String,
      product: json['product'] == null
          ? null
          : NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
      finalDate: json['finalDate'] as String?,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$NetworkPromosToJson(NetworkPromos instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'discount': instance.discount,
      'productId': instance.productId,
      'product': instance.product,
      'finalDate': instance.finalDate,
      'imageUrl': instance.imageUrl,
    };
