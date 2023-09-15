// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkUser _$NetworkUserFromJson(Map<String, dynamic> json) => NetworkUser(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      secondName: json['secondName'] as String?,
      mobileNumber: json['mobileNumber'] as String,
      city: json['city'] as String?,
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$NetworkUserToJson(NetworkUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'city': instance.city,
      'instagram': instance.instagram,
    };

NetworkProfileUser _$NetworkProfileUserFromJson(Map<String, dynamic> json) =>
    NetworkProfileUser(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      secondName: json['secondName'] as String?,
      mobileNumber: json['mobileNumber'] as String,
      city: NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      novaPost:
          NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$NetworkProfileUserToJson(NetworkProfileUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'city': instance.city,
      'novaPost': instance.novaPost,
      'instagram': instance.instagram,
    };

NetworkPasswordUser _$NetworkPasswordUserFromJson(Map<String, dynamic> json) =>
    NetworkPasswordUser(
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$NetworkPasswordUserToJson(
        NetworkPasswordUser instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
