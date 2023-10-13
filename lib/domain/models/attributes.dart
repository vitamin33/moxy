import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class Attributes implements Copyable<Attributes> {
  List<ProductColor> colors;
  List<ProductMaterial> materials;
  List<ProductSize> sizes;
  List<String> productCategories;

  Attributes({
    required this.sizes,
    required this.colors,
    required this.materials,
    required this.productCategories,
  });

  static Attributes defaultAttributes() {
    return Attributes(
      materials: [],
      colors: [],
      sizes: [],
      productCategories: [],
    );
  }

  @override
  Attributes copyWith({
    List<ProductSize>? sizes,
    List<ProductMaterial>? materials,
    List<ProductColor>? colors,
    List<String>? productCategories,
  }) {
    return Attributes(
      materials: materials ?? this.materials,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      productCategories: productCategories ?? this.productCategories,
    );
  }
}
