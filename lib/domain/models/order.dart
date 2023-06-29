import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/product.dart';

class Order implements Copyable<Order> {
  String? _id;
  int cashAdvanceValue;
  NetworkNovaPost novaPost;
  City city;
  DeliveryType deliveryType;
  String status;
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
        novaPost: NetworkNovaPost(number: 0, ref: '', postMachineType: ''),
        deliveryType: DeliveryType.novaPost,
        status: '',
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
    NetworkNovaPost? novaPost,
    City? city,
    int? ukrPostNumber,
    DeliveryType? deliveryType,
    String? status,
    PaymentType? paymentType,
    Client? client,
    List<OrderedItem>? orderedItems,
    String? createdAt,
    String? updatedAt,
  }) {
    return Order(
        id: id ?? this._id,
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
  String city;

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
        id: '', mobileNumber: '', firstName: '', secondName: '', city: 'Lviv');
  }

  Client copyWith(
      {String? id,
      String? mobileNumber,
      String? firstName,
      String? secondName,
      String? city}) {
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
  String productId;
  String productName;
  List<Dimension> dimensions;
  String? imageUrl;

  OrderedItem(
      {required this.productId,
      required this.productName,
      required this.dimensions,
      this.imageUrl});

  static OrderedItem defaultOrderedItem() {
    return OrderedItem(
        productId: '', productName: '', dimensions: [], imageUrl: null);
  }

  OrderedItem copyWith({
    String? productId,
    String? productName,
    List<Dimension>? dimensions,
    String? imageUrl,
  }) {
    return OrderedItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      dimensions: dimensions ?? this.dimensions,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
