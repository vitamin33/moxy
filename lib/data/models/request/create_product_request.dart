import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';

part 'create_product_request.g.dart';

@JsonSerializable()
class CreateProduct {
  final String name;
  final String description;
  final double costPrice;
  final double salePrice;
  final List<Dimension> dimensions;
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
class Dimension {
  final String color;
  final int quantity;

  Dimension({required this.color,required this.quantity});

  factory Dimension.fromJson(Map<String, dynamic> json) =>
      _$DimensionFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionToJson(this);
}

