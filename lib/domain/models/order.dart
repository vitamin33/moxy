import 'package:flutter/foundation.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/status.dart';
import 'package:moxy/domain/models/warehouse.dart';

class Order implements Copyable<Order> {
  String? _id;
  int cashAdvanceValue;
  Warehouse? novaPost;
  City? city;
  DeliveryType deliveryType;
  Status status;
  PaymentType paymentType;
  Client client;
  List<OrderedItem> orderedItems;
  String createdAt;
  String updatedAt;

  Order({
    String? id,
    required this.cashAdvanceValue,
    required this.novaPost,
    required this.city,
    required this.deliveryType,
    required this.status,
    required this.paymentType,
    required this.client,
    required this.orderedItems,
    required this.createdAt,
    required this.updatedAt,
  }) : _id = id;

  String? get id => _id;

  static Order defaultOrder() {
    return Order(
        id: '',
        cashAdvanceValue: 0,
        city: City.defaultCity(),
        novaPost: Warehouse.defaultWarehouse(),
        deliveryType: DeliveryType.novaPost,
        status: Status.defaultStatus(),
        paymentType: PaymentType.cashAdvance,
        client: Client.defaultClient(),
        orderedItems: [],
        createdAt: '',
        updatedAt: '');
  }

  @override
  Order copyWith({
    String? id,
    int? cashAdvanceValue,
    Warehouse? novaPost,
    City? city,
    int? ukrPostNumber,
    DeliveryType? deliveryType,
    Status? status,
    PaymentType? paymentType,
    Client? client,
    List<OrderedItem>? orderedItems,
    String? createdAt,
    String? updatedAt,
  }) {
    return Order(
        id: id ?? _id,
        cashAdvanceValue: cashAdvanceValue ?? this.cashAdvanceValue,
        novaPost: novaPost ?? this.novaPost,
        city: city ?? this.city,
        deliveryType: deliveryType ?? this.deliveryType,
        status: status ?? this.status,
        paymentType: paymentType ?? this.paymentType,
        client: client ?? this.client,
        orderedItems: orderedItems ?? this.orderedItems,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}

class Client {
  String? _id;
  String mobileNumber;
  String firstName;
  String secondName;
  City? city;

  Client(
      {String? id,
      required this.city,
      required this.firstName,
      required this.mobileNumber,
      required this.secondName})
      : _id = id;
  String? get id => _id;

  static Client defaultClient() {
    return Client(
      id: '',
      mobileNumber: '',
      firstName: '',
      secondName: '',
      city: City.defaultCity(),
    );
  }

  Client copyWith(
      {String? id,
      String? mobileNumber,
      String? firstName,
      String? secondName,
      City? city}) {
    return Client(
      id: id ?? this._id,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      city: city ?? this.city,
    );
  }
}

class OrderedItem {
  String? productId;
  String productName;
  List<Dimension> dimensions;
  String? imageUrl;
  String productPrice;

  OrderedItem(
      {required this.productId,
      required this.productName,
      required this.dimensions,
      required this.productPrice});

  static OrderedItem defaultOrderedItem() {
    return OrderedItem(
        productId: '', productName: '', dimensions: [], productPrice: '0');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderedItem &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          listEquals(dimensions, other.dimensions);

  @override
  int get hashCode => productId.hashCode ^ dimensions.hashCode;

  OrderedItem copyWith(
      {String? productId,
      String? productName,
      List<Dimension>? dimensions,
      String? productPrice}) {
    return OrderedItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      dimensions: dimensions ?? this.dimensions,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  int fullOrderPrice() {
    double productPrice = double.parse(this.productPrice);
    return dimensions
        .map((e) => (e.quantity * productPrice).toInt())
        .reduce((total, element) => total + element);
  }
}

extension OrderListExtensions on List<Order> {
  List<Order> combineOrders(List<Order> otherList) {
    // Create a map to store unique orders based on their IDs
    final Map<String, Order> uniqueOrders = {};

    // Add orders from this list to the map
    for (final order in this) {
      if (order.id == null) {
        continue;
      }
      uniqueOrders[order.id!] = order;
    }

    // Add orders from the other list to the map
    for (final order in otherList) {
      uniqueOrders[order.id!] = order;
    }

    // Convert the map values back to a list
    final List<Order> combinedList = uniqueOrders.values.toList();
    // Sort the combined list based on the createdAt field
    combinedList.sort((a, b) {
      // Convert the createdAt strings to DateTime objects for comparison
      final DateTime dateTimeA = DateTime.parse(a.createdAt);
      final DateTime dateTimeB = DateTime.parse(b.createdAt);

      // Compare DateTime objects
      return dateTimeB.compareTo(dateTimeA);
    });

    return combinedList;
  }
}
