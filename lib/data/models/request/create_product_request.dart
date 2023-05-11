import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_request.g.dart';

@JsonSerializable()
class CreateProduct {
  final String name;
  final String description;
  final double costPrice;
  final double salePrice;
  final List<NetworkDimension> dimensions;
  final List<String> images;
  final String idName;

  CreateProduct({
    required this.name,
    required this.description,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.images,
    required this.idName,
  });

  factory CreateProduct.fromJson(Map<String, dynamic> json) =>
      _$CreateProductFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductToJson(this);
}

@JsonSerializable()
class NetworkDimension {
  final String color;
  final int quantity;

  NetworkDimension({required this.color, required this.quantity});

  factory NetworkDimension.fromJson(Map<String, dynamic> json) =>
      _$NetworkDimensionFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkDimensionToJson(this);
}
