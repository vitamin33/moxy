// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkRegister _$NetworkRegisterFromJson(Map<String, dynamic> json) =>
    NetworkRegister(
      firstName: json['name'] as String,
      secondName: json['name'] as String,
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$NetworkRegisterToJson(NetworkRegister instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'password': instance.password,
    };

NetworkConfirmationCode _$NetworkConfirmationCodeFromJson(
        Map<String, dynamic> json) =>
    NetworkConfirmationCode(
      email: json['email'] as String,
      confirmationCode: json['confirmationCode'] as String,
    );

Map<String, dynamic> _$NetworkConfirmationCodeToJson(
        NetworkConfirmationCode instance) =>
    <String, dynamic>{
      'email': instance.email,
      'confirmationCode': instance.confirmationCode,
    };
