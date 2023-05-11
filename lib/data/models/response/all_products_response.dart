import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';

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
  double costPrice;
  double salePrice;
  List<Dimension> dimensions;
  List<String> images;
  String idName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
