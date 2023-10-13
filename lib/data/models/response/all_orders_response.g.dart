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

ProfileOrdersResponse _$ProfileOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileOrdersResponse(
      (json['profileOrders'] as List<dynamic>?)
          ?.map((e) => NetworkProfileOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileOrdersResponseToJson(
        ProfileOrdersResponse instance) =>
    <String, dynamic>{
      'profileOrders': instance.profileOrders,
    };

NetworkOrder _$NetworkOrderFromJson(Map<String, dynamic> json) => NetworkOrder(
      id: json['_id'] as String?,
      cashAdvanceValue: json['cashAdvanceValue'] as int,
      novaPost: json['novaPost'] == null
          ? null
          : NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
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
      'cashAdvanceValue': instance.cashAdvanceValue,
      'novaPost': instance.novaPost,
      'city': instance.city,
      'deliveryType': instance.deliveryType,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'client': instance.client,
      'orderedItems': instance.orderedItems,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

NetworkProfileOrder _$NetworkProfileOrderFromJson(Map<String, dynamic> json) =>
    NetworkProfileOrder(
      id: json['_id'] as String?,
      cashAdvanceValue: json['cashAdvanceValue'] as int,
      novaPost: json['novaPost'] == null
          ? null
          : NetworkNovaPost.fromJson(json['novaPost'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      deliveryType: json['deliveryType'] as String,
      status: json['status'] as String,
      paymentType: json['paymentType'] as String,
      client: json['client'] as String?,
      orderedItems: (json['orderedItems'] as List<dynamic>)
          .map((e) =>
              NetworkOrderedProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$NetworkProfileOrderToJson(
        NetworkProfileOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cashAdvanceValue': instance.cashAdvanceValue,
      'novaPost': instance.novaPost,
      'city': instance.city,
      'deliveryType': instance.deliveryType,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'orderedItems': instance.orderedItems,
      'client': instance.client,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CreateNetworkClient _$CreateNetworkClientFromJson(Map<String, dynamic> json) =>
    CreateNetworkClient(
      json['_id'] as String?,
      json['city'] == null
          ? null
          : NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      json['firstName'] as String,
      json['mobileNumber'] as String,
      json['secondName'] as String,
      (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateNetworkClientToJson(
        CreateNetworkClient instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'mobileNumber': instance.mobileNumber,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'city': instance.city,
      'orders': instance.orders,
    };

NetworkClient _$NetworkClientFromJson(Map<String, dynamic> json) =>
    NetworkClient(
      id: json['_id'] as String?,
      city: json['city'] == null
          ? null
          : NetworkCity.fromJson(json['city'] as Map<String, dynamic>),
      firstName: json['firstName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      secondName: json['secondName'] as String,
    );

Map<String, dynamic> _$NetworkClientToJson(NetworkClient instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'mobileNumber': instance.mobileNumber,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'city': instance.city,
    };

NetworkOrderedItemResponse _$NetworkOrderedItemResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkOrderedItemResponse(
      json['product'] as String,
      json['productName'] as String?,
      (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['productPrice'] as int?,
    );

Map<String, dynamic> _$NetworkOrderedItemResponseToJson(
        NetworkOrderedItemResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'dimensions': instance.dimensions,
    };

NetworkOrderedProductResponse _$NetworkOrderedProductResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkOrderedProductResponse(
      NetworkProduct.fromJson(json['product'] as Map<String, dynamic>),
      (json['dimensions'] as List<dynamic>)
          .map((e) => NetworkDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetworkOrderedProductResponseToJson(
        NetworkOrderedProductResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'dimensions': instance.dimensions,
    };
