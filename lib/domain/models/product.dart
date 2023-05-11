class Product {
  String? id;
  String name;
  String description;
  double costPrice;
  double salePrice;
  List<Dimension> dimensions;
  List<String> images;
  String idName;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.images,
  });
}

class Dimension {
  final String color;
  final int quantity;

  Dimension({required this.color, required this.quantity});
}
