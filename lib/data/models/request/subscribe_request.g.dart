// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeRequest _$SubscribeRequestFromJson(Map<String, dynamic> json) =>
    SubscribeRequest(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
    );

Map<String, dynamic> _$SubscribeRequestToJson(SubscribeRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
    };
