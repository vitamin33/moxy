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
      novaPostNumber: json['novaPostNumber'] as int,
      deliveryType: json['deliveryType'] as String,
      status: json['status'] as String,
      paymentType: json['paymentType'] as String,
      client:
          CreateNetworkClient.fromJson(json['client'] as Map<String, dynamic>),
      orderedItems: (json['orderedItems'] as List<dynamic>)
          .map((e) =>
              NetworkOrderedItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$NetworkOrderToJson(NetworkOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'novaPostNumber': instance.novaPostNumber,
      'deliveryType': instance.deliveryType,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'client': instance.client,
      'orderedItems': instance.orderedItems,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CreateNetworkClient _$CreateNetworkClientFromJson(Map<String, dynamic> json) =>
    CreateNetworkClient(
      json['city'] as String,
      json['firstName'] as String,
      json['mobileNumber'] as String,
      json['secondName'] as String,
      (json['orders'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateNetworkClientToJson(
        CreateNetworkClient instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'city': instance.city,
      'orders': instance.orders,
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

NetworkOrderedItemResponse _$NetworkOrderedItemResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkOrderedItemResponse(
      json['product'] as String,
      json['productName'] as String,
      (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$NetworkOrderedItemResponseToJson(
        NetworkOrderedItemResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'dimensions': instance.dimensions,
    };
