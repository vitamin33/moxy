import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class Order implements Copyable<Order> {
  String? id;
  int ukrPostNumber;
  String deliveryType;
  String status;
  String paymentType;
  String client;
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
        client: '',
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
    String? client,
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
