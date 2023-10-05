import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_request.g.dart';

@JsonSerializable()
class CreateProduct {
  final String name;
  final String description;
  final double costPriceInUsd;
  final int weightInGrams;
  final double salePrice;
  final List<NetworkDimension> dimensions;
  final List<String> images;
  final String idName;

  CreateProduct({
    required this.name,
    required this.description,
    required this.costPriceInUsd,
    required this.weightInGrams,
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
  final NetworkColor color;
  final NetworkSize? size;
  final NetworkMaterial? material;
  final int quantity;
  final List<String> images;

  NetworkDimension({
    required this.color,
    required this.size,
    required this.material,
    required this.quantity,
    required this.images,
  });

  factory NetworkDimension.fromJson(Map<String, dynamic> json) =>
      _$NetworkDimensionFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkDimensionToJson(this);
}

@JsonSerializable()
class NetworkColor {
  final String id;
  final String name;
  final String hexCode;

  NetworkColor({required this.id, required this.name, required this.hexCode});

  factory NetworkColor.fromJson(Map<String, dynamic> json) =>
      _$NetworkColorFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkColorToJson(this);
}

@JsonSerializable()
class NetworkSize {
  final String id;
  final String name;

  NetworkSize({
    required this.id,
    required this.name,
  });

  factory NetworkSize.fromJson(Map<String, dynamic> json) =>
      _$NetworkSizeFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkSizeToJson(this);
}

@JsonSerializable()
class NetworkMaterial {
  final String id;
  final String name;

  NetworkMaterial({
    required this.id,
    required this.name,
  });

  factory NetworkMaterial.fromJson(Map<String, dynamic> json) =>
      _$NetworkMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkMaterialToJson(this);
}

@JsonSerializable()
class NetworkProductAttributes {
  String? season;
  int weightInGrams;
  String? furniture;
  String? strap;
  int heightInCm;
  int widthInCm;
  int lengthInCm;
  int? depthInCm;
  String? producer;

  NetworkProductAttributes({
    required this.weightInGrams,
    required this.heightInCm,
    required this.widthInCm,
    required this.lengthInCm,
    this.season,
    this.furniture,
    this.depthInCm,
    this.producer,
    this.strap,
  });

  factory NetworkProductAttributes.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductAttributesToJson(this);
}
