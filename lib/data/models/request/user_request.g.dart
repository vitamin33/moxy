// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkGuestUser _$NetworkGuestUserFromJson(Map<String, dynamic> json) =>
    NetworkGuestUser(
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      city: json['city'] as String,
      instagram: json['instagram'] as String,
    );

Map<String, dynamic> _$NetworkGuestUserToJson(NetworkGuestUser instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'city': instance.city,
      'instagram': instance.instagram,
    };
