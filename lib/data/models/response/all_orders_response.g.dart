// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersResponse _$AllOrdersResponseFromJson(Map<String, dynamic> json) =>
    AllOrdersResponse(
      (json['allOrder'] as List<dynamic>?)
          ?.map((e) => NetworkOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrdersResponseToJson(AllOrdersResponse instance) =>
    <String, dynamic>{
      'allOrder': instance.allOrder,
    };

NetworkOrder _$NetworkOrderFromJson(Map<String, dynamic> json) => NetworkOrder(
      id: json['_id'] as String,
      ukrPostNumber: json['ukrPostNumber'] as int?,
      deliveryType: json['deliveryType'] as String,
      status: json['status'] as String,
      paymentType: json['paymentType'] as String,
      client: NetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      orderedItems: (json['orderedItems'] as List<dynamic>)
          .map((e) => NetworkOrderedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    )..novaPostNumber = json['novaPostNumber'] as int?;

Map<String, dynamic> _$NetworkOrderToJson(NetworkOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ukrPostNumber': instance.ukrPostNumber,
      'novaPostNumber': instance.novaPostNumber,
      'deliveryType': instance.deliveryType,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'client': instance.client,
      'orderedItems': instance.orderedItems,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

NetworkClient _$NetworkClientFromJson(Map<String, dynamic> json) =>
    NetworkClient(
      json['city'] as String,
      json['firstName'] as String,
      json['mobileNumber'] as String,
      json['secondName'] as String,
    );

Map<String, dynamic> _$NetworkClientToJson(NetworkClient instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'city': instance.city,
    };

NetworkOrderedItem _$NetworkOrderedItemFromJson(Map<String, dynamic> json) =>
    NetworkOrderedItem(
      json['product'] as String,
      (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$NetworkOrderedItemToJson(NetworkOrderedItem instance) =>
    <String, dynamic>{
      'product': instance.product,
      'imageUrl': instance.imageUrl,
      'dimensions': instance.dimensions,
    };
