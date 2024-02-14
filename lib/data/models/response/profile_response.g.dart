// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkProfile _$NetworkProfileFromJson(Map<String, dynamic> json) =>
    NetworkProfile(
      favoriteProducts: (json['favoriteProducts'] as List<dynamic>)
          .map((e) => NetworkProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      instagram: json['instagram'] as String?,
      city: json['city'] == null
          ? null
          : NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      novaPost: json['novaPost'] == null
          ? null
          : NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      role: json['role'] as String,
      password: json['password'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$NetworkProfileToJson(NetworkProfile instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'instagram': instance.instagram,
      'role': instance.role,
      'favoriteProducts': instance.favoriteProducts,
      'city': instance.city,
      'novaPost': instance.novaPost,
      'password': instance.password,
      'id': instance.id,
    };
