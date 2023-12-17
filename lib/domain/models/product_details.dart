import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/product_advantages.dart';

class ProductDetails implements Copyable<ProductDetails> {
  Product product;
  Dimension dimension;
  List<ProductAdvantages>? productAdvantages;

  ProductDetails({
    required this.product,
    required this.dimension,
    this.productAdvantages
  });

  static ProductDetails defaultProductDetails() {
    return ProductDetails(
      product: Product.defaultProduct(),
      dimension: Dimension.defaultDimension(),
      productAdvantages: []
    );
  }

  @override
  ProductDetails copyWith({
    Product? product,
    Dimension? dimension,
   List<ProductAdvantages>? productAdvantages
  }) {
    return ProductDetails(
      product: product ?? this.product,
      dimension: dimension ?? this.dimension,
      productAdvantages: productAdvantages ?? this.productAdvantages,
    );
  }
}
