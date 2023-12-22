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
  String category;
  bool forSale;
  bool? isFavorite;
  NetworkProductAttributes attributes;
  String? createdAt;
  String? updatedAt;

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
    required this.category,
    required this.forSale,
    required this.isFavorite,
    required this.attributes,
    this.createdAt,
    this.updatedAt,
  });

  factory NetworkProduct.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductToJson(this);
}

@JsonSerializable()
class NetworkProductDetails {
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
  String category;
  bool forSale;
  bool? isFavorite;
  NetworkProductAttributes attributes;
  List<NetworkProductAdantages>? productAdvantages;

  NetworkProductDetails({
    this.id,
    required this.name,
    required this.description,
    required this.costPriceInUsd,
    this.discountPrice,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.category,
    required this.forSale,
    required this.isFavorite,
    required this.attributes,
    required this.productAdvantages,
  });

  factory NetworkProductDetails.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductDetailsToJson(this);
}

@JsonSerializable()
class NetworkProductAdantages {
  String header;
  String imageUrl;
  String? description;

  NetworkProductAdantages({
    required this.header,
    required this.description,
    required this.imageUrl,
  });

  factory NetworkProductAdantages.fromJson(Map<String, dynamic> json) =>
      _$NetworkProductAdantagesFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProductAdantagesToJson(this);
}
