import '../copyable.dart';

class Product implements Copyable<Product> {
  String? id;
  String name;
  String description;
  double costPriceInUsd;
  double discountPrice;
  double costPrice;
  double salePrice;
  List<Dimension> dimensions;
  String idName;
  String category;
  bool forSale;
  bool isFavorite;
  ProductAttributes attributes;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.costPriceInUsd,
    required this.discountPrice,
    required this.costPrice,
    required this.salePrice,
    required this.dimensions,
    required this.idName,
    required this.category,
    required this.forSale,
    required this.isFavorite,
    required this.attributes,
  });

  static Product defaultProduct() {
    return Product(
      name: '',
      description: '',
      costPriceInUsd: 0,
      discountPrice: 0,
      costPrice: 0,
      salePrice: 0,
      dimensions: [],
      idName: '',
      category: '',
      forSale: false,
      isFavorite: false,
      attributes: ProductAttributes.defaultAttributes(),
    );
  }

  @override
  Product copyWith({
    String? id,
    String? name,
    String? idName,
    String? category,
    String? description,
    double? costPriceInUsd,
    double? discountPrice,
    double? costPrice,
    double? salePrice,
    List<Dimension>? dimensions,
    bool? forSale,
    bool? isFavorite,
    ProductAttributes? attributes,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      costPriceInUsd: costPriceInUsd ?? this.costPriceInUsd,
      discountPrice: discountPrice ?? this.discountPrice,
      costPrice: costPrice ?? this.costPrice,
      salePrice: salePrice ?? this.salePrice,
      dimensions: dimensions ?? this.dimensions,
      idName: idName ?? this.idName,
      category: category ?? this.category,
      forSale: forSale ?? this.forSale,
      isFavorite: isFavorite ?? this.isFavorite,
      attributes: attributes ?? this.attributes,
    );
  }

  bool hasImages() {
    return dimensions.where((element) => element.images.isNotEmpty).isNotEmpty;
  }

  int totalQuantity() {
    int sum = 0;
    for (final dimension in dimensions) {
      sum += dimension.quantity;
    }
    return sum;
  }
}

class ProductAttributes implements Copyable<ProductAttributes> {
  String? season;
  int weightInGrams;
  String? furniture;
  String? strap;
  int heightInCm;
  int widthInCm;
  int lengthInCm;
  int? depthInCm;
  String? producer;
  String? style;

  ProductAttributes({
    required this.weightInGrams,
    required this.heightInCm,
    required this.widthInCm,
    required this.lengthInCm,
    this.depthInCm,
    this.season,
    this.furniture,
    this.strap,
    this.producer,
    this.style,
  });

  static ProductAttributes defaultAttributes() {
    return ProductAttributes(
      weightInGrams: 0,
      heightInCm: 0,
      widthInCm: 0,
      lengthInCm: 0,
    );
  }

  @override
  ProductAttributes copyWith({
    int? weightInGrams,
    int? heightInCm,
    int? widthInCm,
    int? lengthInCm,
    int? depthInCm,
    String? season,
    String? furniture,
    String? strap,
    String? producer,
    String? style,
  }) {
    return ProductAttributes(
      weightInGrams: weightInGrams ?? this.weightInGrams,
      heightInCm: heightInCm ?? this.heightInCm,
      widthInCm: widthInCm ?? this.widthInCm,
      lengthInCm: lengthInCm ?? this.lengthInCm,
      depthInCm: depthInCm ?? this.depthInCm,
      season: season ?? this.season,
      furniture: furniture ?? this.furniture,
      strap: strap ?? this.strap,
      producer: producer ?? this.producer,
      style: style ?? this.style,
    );
  }
}

class Dimension implements Copyable<Dimension> {
  ProductColor color;
  ProductMaterial? material;
  bool isSelected;
  int quantity;
  ProductSize? size;
  List<ImagePath> images;

  Dimension({
    required this.color,
    required this.quantity,
    this.isSelected = false,
    required this.material,
    required this.size,
    required this.images,
  });

  static Dimension defaultDimension() {
    return Dimension(
      color: ProductColor.defaultColor(),
      material: ProductMaterial.defaultMaterial(),
      size: ProductSize.defaultSize(),
      isSelected: false,
      quantity: 0,
      images: [],
    );
  }

  @override
  Dimension copyWith({
    ProductColor? color,
    int? quantity,
    bool? isSelected,
    ProductMaterial? material,
    ProductSize? size,
    List<ImagePath>? images,
  }) {
    return Dimension(
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
      material: material ?? this.material,
      size: size ?? this.size,
      images: images ?? this.images,
    );
  }

  @override
  bool operator ==(other) {
    if (other is! Dimension) {
      return false;
    }
    return color == (other).color;
  }

  @override
  int get hashCode {
    return color.hashCode;
  }
}

class ProductColor {
  final String id;
  final String name;
  final String hexCode;
  bool isSelected;

  ProductColor({
    required this.id,
    required this.name,
    required this.hexCode,
    this.isSelected = false,
  });

  static ProductColor defaultColor() {
    return ProductColor(id: '', name: 'Black', hexCode: '000000');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductColor && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class ProductSize {
  final String id;
  final String name;

  ProductSize({
    required this.id,
    required this.name,
  });

  static ProductSize defaultSize() {
    return ProductSize(id: '', name: 'M');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductColor && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class ProductMaterial {
  final String name;
  final String id;

  ProductMaterial({
    required this.id,
    required this.name,
  });
  static ProductMaterial defaultMaterial() {
    return ProductMaterial(id: '', name: 'Leather');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductColor && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

enum Type { network, file }

class ImagePath implements Copyable<ImagePath> {
  Type type;
  String imagePath;

  ImagePath({required this.type, required this.imagePath});

  @override
  ImagePath copyWith({Type? type, String? imagePath}) {
    return ImagePath(
        type: type ?? this.type, imagePath: imagePath ?? this.imagePath);
  }

  @override
  bool operator ==(other) {
    if (other is! ImagePath) {
      return false;
    }
    return type == (other).type && imagePath == (other).imagePath;
  }

  @override
  int get hashCode {
    return imagePath.hashCode + type.hashCode;
  }
}
