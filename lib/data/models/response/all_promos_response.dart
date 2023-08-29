import 'package:freezed_annotation/freezed_annotation.dart';

import 'all_products_response.dart';

part 'all_promos_response.g.dart';

@JsonSerializable()
class AllPromosResponse {
  List<NetworkPromos>? allPromos;

  AllPromosResponse(this.allPromos);

  factory AllPromosResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPromosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllPromosResponseToJson(this);
}

@JsonSerializable()
class NetworkPromos {
  @JsonKey(name: '_id')
  String? id;
  String title;
  int discount;
  String productId;
  NetworkProduct? product;
  String? finalDate;
  String imageUrl;

  NetworkPromos({
    this.id,
    required this.title,
    required this.discount,
    required this.productId,
    this.product,
    this.finalDate,
    required this.imageUrl,
  });

  factory NetworkPromos.fromJson(Map<String, dynamic> json) =>
      _$NetworkPromosFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkPromosToJson(this);
}
