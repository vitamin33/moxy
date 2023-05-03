import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_request.g.dart';

@JsonSerializable()
class CreateProduct {
  final String name;
  final String description;
  final int warehouseQuantity;
  final double costPrice;
  final double salePrice;
  final String color;
  final List<String> images;

  CreateProduct({
    required this.name,
    required this.description,
    required this.costPrice,
    required this.warehouseQuantity,
    required this.salePrice,
    required this.color,
    required this.images,
  });

  factory CreateProduct.fromJson(Map<String, dynamic> json) =>
      _$CreateProductFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductToJson(this);
}
