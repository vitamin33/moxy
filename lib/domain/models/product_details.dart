import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class ProductDetails implements Copyable<ProductDetails> {
  Product product;
  Dimension dimension;

  ProductDetails({
    required this.product,
    required this.dimension,
  });

  static ProductDetails defaultProductDetails() {
    return ProductDetails(
      product: Product.defaultProduct(),
      dimension: Dimension.defaultDimension(),
    );
  }

  @override
  ProductDetails copyWith({
    Product? product,
    Dimension? dimension,
  }) {
    return ProductDetails(
      product: product ?? this.product,
      dimension: dimension ?? this.dimension,
    );
  }
}