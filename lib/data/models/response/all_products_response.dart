import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_products_response.g.dart';

@JsonSerializable()
class AllProductsResponse {
  List<Product>? allProducts;

  AllProductsResponse(this.allProducts);

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductsResponseToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String id;
  String name;
  String description;
  int warehouseQuantity;
  double costPrice;
  double salePrice;
  String color;
  List images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.warehouseQuantity,
    required this.costPrice,
    required this.salePrice,
    required this.color,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
