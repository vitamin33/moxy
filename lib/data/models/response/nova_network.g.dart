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

NovaNetworkEN _$NovaNetworkENFromJson(Map<String, dynamic> json) =>
    NovaNetworkEN(
      json['Ref'] as String,
      json['Description'] as String,
      json['DateTime'] as String,
      json['CityRecipient'] as String,
      json['Cost'] as String,
      json['ContactRecipient'] as String,
      json['CityRecipientDescription'] as String,
      json['RecipientAddressDescription'] as String,
      json['RecipientContactPerson'] as String,
      json['RecipientsPhone'] as String,
      json['RecipientAddress'] as String,
      json['IntDocNumber'] as String,
    );

Map<String, dynamic> _$NovaNetworkENToJson(NovaNetworkEN instance) =>
    <String, dynamic>{
      'Ref': instance.ref,
      'Description': instance.description,
      'DateTime': instance.dateTime,
      'Cost': instance.cost,
      'CityRecipient': instance.cityRecepientRef,
      'ContactRecipient': instance.contactRecipientRef,
      'RecipientsPhone': instance.recipientPhone,
      'CityRecipientDescription': instance.cityRecipientDescription,
      'RecipientContactPerson': instance.recipientContactPerson,
      'RecipientAddressDescription': instance.recipientAddressDescription,
      'RecipientAddress': instance.recipientAddressRef,
      'IntDocNumber': instance.docNumber,
    };
