import 'package:moxy/constant/product_colors.dart';

import '../copyable.dart';

class Product implements Copyable<Product> {
  String? id;
  String name;
  String description;
  double costPrice;
  double salePrice;
  Map<int, Dimension> dimensions;
  List<String> images;
  String idName;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.images,
  });

  static Product defaultProduct() {
    return Product(
        name: '',
        description: '',
        costPrice: 0,
        salePrice: 0,
        dimensions: {},
        idName: '',
        images: []);
  }

  @override
  Product copyWith({
    String? name,
    String? idName,
    String? description,
    double? costPrice,
    double? salePrice,
    Map<int, Dimension>? dimensions,
    List<String>? images,
  }) {
    return Product(
        name: name ?? this.name,
        description: description ?? this.description,
        costPrice: costPrice ?? this.costPrice,
        salePrice: salePrice ?? this.salePrice,
        dimensions: dimensions ?? this.dimensions,
        idName: idName ?? this.idName,
        images: images ?? this.images);
  }
}

class Dimension implements Copyable<Dimension> {
  String color;
  int quantity;

  Dimension({required this.color, required this.quantity});

  static Dimension defaultDimension() {
    return Dimension(color: ProductColor.black.color, quantity: 0);
  }

  @override
  Dimension copyWith({String? color, int? quantity}) {
    return Dimension(
        color: color ?? this.color, quantity: quantity ?? this.quantity);
  }

  @override
  bool operator ==(other) {
    if (other is! Dimension) {
      return false;
    }
    return color == (other).color;
  }

  @override
  int get hashCode {
    return color.hashCode;
  }
}
