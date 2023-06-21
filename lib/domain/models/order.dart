import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class Order implements Copyable<Order> {
  String? id;
  int? ukrPostNumber;
  int? novaPostNumber;
  DeliveryType deliveryType;
  String status;
  PaymentType paymentType;
  Client client;
  List<OrderedItem> orderedItems;
  String createdAt;
  String updatedAt;

  Order({
    this.id,
    required this.ukrPostNumber,
    required this.deliveryType,
    required this.status,
    required this.paymentType,
    required this.client,
    required this.orderedItems,
    required this.createdAt,
    required this.updatedAt,
  });

  static Order defaultOrder() {
    return Order(
        id: '',
        ukrPostNumber: 0,
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
        id: id ?? this.id,
        ukrPostNumber: ukrPostNumber ?? this.ukrPostNumber,
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
  String mobileNumber;
  String firstName;
  String secondName;
  String city;

  Client(
      {required this.city,
      required this.firstName,
      required this.mobileNumber,
      required this.secondName});

  static Client defaultClient() {
    return Client(
        mobileNumber: '', firstName: '', secondName: '', city: 'Lviv');
  }

  Client copyWith(
      {String? mobileNumber,
      String? firstName,
      String? secondName,
      String? city}) {
    return Client(
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
