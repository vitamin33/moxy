import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class Order implements Copyable<Order> {
  String? id;
  int? ukrPostNumber;
  int? novaPostNumber;
  String deliveryType;
  String status;
  String paymentType;
  Client client;
  List<Product> products;
  String createdAt;
  String updatedAt;

  Order({
    this.id,
    required this.ukrPostNumber,
    required this.deliveryType,
    required this.status,
    required this.paymentType,
    required this.client,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  static Order defaultOrder() {
    return Order(
        id: '',
        ukrPostNumber: 0,
        deliveryType: '',
        status: '',
        paymentType: '',
        client: Client.defaultClient(),
        products: [],
        createdAt: '',
        updatedAt: '');
  }

  @override
  Order copyWith({
    String? id,
    int? ukrPostNumber,
    String? deliveryType,
    String? status,
    String? paymentType,
    Client? client,
    List<Product>? products,
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
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}

class Client {
  String? mobileNumber;
  String? firstName;
  String? secondName;
  String? city;

  Client({this.city, this.firstName, this.mobileNumber, this.secondName});

  static Client defaultClient() {
    return Client(
        mobileNumber: '',
        firstName: 'Ivan',
        secondName: 'Mikolenko',
        city: 'Lviv');
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
