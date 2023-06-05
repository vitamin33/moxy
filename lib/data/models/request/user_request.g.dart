// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkUser _$NetworkUserFromJson(Map<String, dynamic> json) => NetworkUser(
      firstName: json['firstName'] as String?,
      secondName: json['secondName'] as String?,
      mobileNumber: json['mobileNumber'] as String,
      city: json['city'] as String?,
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$NetworkUserToJson(NetworkUser instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'city': instance.city,
      'instagram': instance.instagram,
    };
