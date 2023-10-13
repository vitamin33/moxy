// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mono_create_invoice_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInvoiceRequest _$CreateInvoiceRequestFromJson(
        Map<String, dynamic> json) =>
    CreateInvoiceRequest(
      amount: json['amount'] as int,
      ccy: json['ccy'] as int,
      redirectUrl: json['redirectUrl'] as String,
      merchantPaymInfo: NetworkMerchantInfo.fromJson(
          json['merchantPaymInfo'] as Map<String, dynamic>),
      paymentType: json['paymentType'] as String,
      webHookUrl: json['webHookUrl'] as String,
    );

Map<String, dynamic> _$CreateInvoiceRequestToJson(
        CreateInvoiceRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'ccy': instance.ccy,
      'redirectUrl': instance.redirectUrl,
      'webHookUrl': instance.webHookUrl,
      'paymentType': instance.paymentType,
      'merchantPaymInfo': instance.merchantPaymInfo,
    };

NetworkMerchantInfo _$NetworkMerchantInfoFromJson(Map<String, dynamic> json) =>
    NetworkMerchantInfo(
      basketOrder: (json['basketOrder'] as List<dynamic>)
          .map((e) => MonoBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment: json['comment'] as String,
      destination: json['destination'] as String,
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$NetworkMerchantInfoToJson(
        NetworkMerchantInfo instance) =>
    <String, dynamic>{
      'basketOrder': instance.basketOrder,
      'comment': instance.comment,
      'destination': instance.destination,
      'reference': instance.reference,
    };

MonoBasketItem _$MonoBasketItemFromJson(Map<String, dynamic> json) =>
    MonoBasketItem(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      sum: json['sum'] as int,
      code: json['code'] as String,
      icon: json['icon'] as String,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$MonoBasketItemToJson(MonoBasketItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'sum': instance.sum,
      'icon': instance.icon,
      'unit': instance.unit,
      'code': instance.code,
    };
