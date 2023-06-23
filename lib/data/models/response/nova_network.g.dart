// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova_network.dart';

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

NovaNetworkWarehouse _$NovaNetworkWarehouseFromJson(
        Map<String, dynamic> json) =>
    NovaNetworkWarehouse(
      json['TypeOfWarehouse'] as String,
      json['Description'] as String,
      json['PostMachineType'] as String,
      json['Number'] as String,
    );

Map<String, dynamic> _$NovaNetworkWarehouseToJson(
        NovaNetworkWarehouse instance) =>
    <String, dynamic>{
      'TypeOfWarehouse': instance.ref,
      'Description': instance.description,
      'PostMachineType': instance.postMachineType,
      'Number': instance.number,
    };
