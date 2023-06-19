// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova_network_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovaNetworkCity _$NovaNetworkCityFromJson(Map<String, dynamic> json) =>
    NovaNetworkCity(
      json['MainDescription'] as String,
      json['Ref'] as String,
      json['DeliveryCity'] as String,
      json['Present'] as String,
    );

Map<String, dynamic> _$NovaNetworkCityToJson(NovaNetworkCity instance) =>
    <String, dynamic>{
      'MainDescription': instance.mainDescription,
      'Ref': instance.ref,
      'DeliveryCity': instance.deliveryCityRef,
      'Present': instance.presentName,
    };
