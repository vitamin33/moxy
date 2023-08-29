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
      orders: (json['orders'] as List<dynamic>)
          .map((e) => NetworkOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: json['role'] as String,
      password: json['password'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$NetworkProfileToJson(NetworkProfile instance) =>
    <String, dynamic>{
      'favoriteProducts': instance.favoriteProducts,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'orders': instance.orders,
      'role': instance.role,
      'password': instance.password,
      'id': instance.id,
    };
