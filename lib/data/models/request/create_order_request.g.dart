// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
      deliveryType: $enumDecode(_$DeliveryTypeEnumMap, json['deliveryType']),
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      novaPostNumber: json['novaPostNumber'] as int,
      selectedProducts: (json['selectedProducts'] as List<dynamic>)
          .map((e) => NetworkProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'deliveryType': _$DeliveryTypeEnumMap[instance.deliveryType]!,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType]!,
      'novaPostNumber': instance.novaPostNumber,
      'selectedProducts': instance.selectedProducts,
      'client': instance.client,
      'status': instance.status,
    };

const _$DeliveryTypeEnumMap = {
  DeliveryType.NovaPost: 'NovaPost',
  DeliveryType.UkrPost: 'UkrPost',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CashAdvance: 'CashAdvance',
  PaymentType.FullPayment: 'FullPayment',
};
