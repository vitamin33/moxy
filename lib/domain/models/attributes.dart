import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class Attributes implements Copyable<Attributes> {
  List<ProductColor> colors;
  List<ProductMaterial> materials;
  List<ProductSize> sizes;

  Attributes({
    required this.sizes,
    required this.colors,
    required this.materials,
  });

  static Attributes defaultAttributes() {
    return Attributes(
      materials: [],
      colors: [],
      sizes: [],
    );
  }

  @override
  Attributes copyWith({
    List<ProductSize>? sizes,
    List<ProductMaterial>? materials,
    List<ProductColor>? colors,
  }) {
    return Attributes(
      materials: materials ?? this.materials,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }
}
