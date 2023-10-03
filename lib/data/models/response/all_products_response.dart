import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';

part 'all_products_response.g.dart';

@JsonSerializable()
class AllProductsResponse {
  List<NetworkProduct>? allProducts;

  AllProductsResponse(this.allProducts);

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductsResponseToJson(this);
}

@JsonSerializable()
class NetworkProduct {
  @JsonKey(name: '_id')
  String? id;
  String name;
  String? description;
  double costPriceInUsd;
  double? discountPrice;
  double? costPrice;
  double salePrice;
  List<NetworkDimension>? dimensions;
  String idName;
  bool forSale;
  NetworkProductAttributes attributes;

  NetworkProduct({
    this.id,
    required this.name,
    required this.description,
    required this.costPriceInUsd,
    this.discountPrice,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.forSale,
    required this.attributes,
  });

  factory NetworkProduct.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductToJson(this);
}
