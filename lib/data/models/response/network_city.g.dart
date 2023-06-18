// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkCity _$NetworkCityFromJson(Map<String, dynamic> json) => NetworkCity(
      json['MainDescription'] as String,
      json['Ref'] as String,
      json['DeliveryCity'] as String,
      json['Present'] as String,
    );

Map<String, dynamic> _$NetworkCityToJson(NetworkCity instance) =>
    <String, dynamic>{
      'MainDescription': instance.mainDescription,
      'Ref': instance.ref,
      'DeliveryCity': instance.deliveryCityRef,
      'Present': instance.presentName,
    };
