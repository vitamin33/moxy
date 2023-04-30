import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_request.g.dart';

@JsonSerializable()
class CreateProduct {
  final String name;
  final String description;
  final int costPrice;
  final double regularPrice;
  final double salePrice;
  final String color;
  final List<String> images;
  //final File? imageFile;

  CreateProduct({
    required this.name,
    required this.description,
    required this.costPrice,
    required this.regularPrice,
    required this.salePrice,
    required this.color,
    required this.images,
  });

  factory CreateProduct.fromJson(Map<String, dynamic> json) =>
      _$CreateProductFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductToJson(this);
}
