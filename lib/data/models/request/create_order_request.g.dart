// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
      deliveryType: json['deliveryType'] as String,
      paymentType: json['paymentType'] as String,
      novaPost:
          NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => NetworkOrderedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      city: NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      status: json['status'] as String,
      cashAdvanceValue: json['cashAdvanceValue'] as int,
    );

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'deliveryType': instance.deliveryType,
      'paymentType': instance.paymentType,
      'novaPost': instance.novaPost,
      'products': instance.products,
      'client': instance.client,
      'city': instance.city,
      'status': instance.status,
      'cashAdvanceValue': instance.cashAdvanceValue,
    };

NetworkOrderedItem _$NetworkOrderedItemFromJson(Map<String, dynamic> json) =>
    NetworkOrderedItem(
      id: json['_id'] as String?,
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkOrderedItemToJson(NetworkOrderedItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'dimensions': instance.dimensions,
    };

NetworkCity _$NetworkCityFromJson(Map<String, dynamic> json) => NetworkCity(
      ref: json['ref'] as String?,
      mainDescription: json['mainDescription'] as String?,
      deliveryCityRef: json['deliveryCityRef'] as String?,
      presentName: json['presentName'] as String?,
    );

Map<String, dynamic> _$NetworkCityToJson(NetworkCity instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'mainDescription': instance.mainDescription,
      'deliveryCityRef': instance.deliveryCityRef,
      'presentName': instance.presentName,
    };

NetworkNovaPost _$NetworkNovaPostFromJson(Map<String, dynamic> json) =>
    NetworkNovaPost(
      ref: json['ref'] as String,
      presentName: json['presentName'] as String,
      postMachineType: json['postMachineType'] as String?,
      number: json['number'] as int,
    );

Map<String, dynamic> _$NetworkNovaPostToJson(NetworkNovaPost instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'presentName': instance.presentName,
      'postMachineType': instance.postMachineType,
      'number': instance.number,
    };
