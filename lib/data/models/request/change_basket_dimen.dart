import 'package:freezed_annotation/freezed_annotation.dart';

import 'create_product_request.dart';

part 'change_basket_dimen.g.dart';

@JsonSerializable()
class NetworkAddOrChange {
  NetworkChangeBasketDimen product;

  NetworkAddOrChange({
    required this.product,
  });
  factory NetworkAddOrChange.fromJson(Map<String, dynamic> json) =>
      _$NetworkAddOrChangeFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkAddOrChangeToJson(this);
}

@JsonSerializable()
class NetworkChangeBasketDimen {
  String productId;
  NetworkDimension dimension;

  NetworkChangeBasketDimen({
    required this.productId,
    required this.dimension,
  });
  factory NetworkChangeBasketDimen.fromJson(Map<String, dynamic> json) =>
      _$NetworkChangeBasketDimenFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkChangeBasketDimenToJson(this);
}

@JsonSerializable()
class NetworkRemoveProduct {
  String productId;

  NetworkRemoveProduct({
    required this.productId,
  });
  factory NetworkRemoveProduct.fromJson(Map<String, dynamic> json) =>
      _$NetworkRemoveProductFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkRemoveProductToJson(this);
}
