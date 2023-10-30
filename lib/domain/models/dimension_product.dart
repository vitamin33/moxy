import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class DimensionProduct implements Copyable<DimensionProduct> {
  String? id;
  String name;
  String description;
  double costPriceInUsd;
  double salePrice;
  Dimension dimension;
  String idName;
  bool isSelected;
  bool isAvailableInStock;
  int selectedQuantity;

  DimensionProduct({
    this.id,
    required this.name,
    required this.description,
    required this.costPriceInUsd,
    required this.salePrice,
    required this.dimension,
    required this.idName,
    required this.isSelected,
    required this.isAvailableInStock,
    required this.selectedQuantity,
  });

  @override
  DimensionProduct copyWith({
    String? name,
    String? idName,
    String? description,
    double? costPriceInUsd,
    double? salePrice,
    Dimension? dimension,
    bool? isSelected,
    bool? isAvailableInStock,
    int? selectedQuantity,
  }) {
    return DimensionProduct(
      name: name ?? this.name,
      description: description ?? this.description,
      costPriceInUsd: costPriceInUsd ?? this.costPriceInUsd,
      salePrice: salePrice ?? this.salePrice,
      dimension: dimension ?? this.dimension,
      idName: idName ?? this.idName,
      isSelected: isSelected ?? this.isSelected,
      isAvailableInStock: isAvailableInStock ?? this.isAvailableInStock,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }
}
