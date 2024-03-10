import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/product_advantages.dart';

class ProductDetails implements Copyable<ProductDetails> {
  Product product;
  Dimension selectedDimension;
  List<ProductAdvantages>? productAdvantages;

  ProductDetails({
    required this.product,
    required this.selectedDimension,
    this.productAdvantages,
  });

  static ProductDetails defaultProductDetails() {
    return ProductDetails(
        product: Product.defaultProduct(),
        selectedDimension: Dimension.defaultDimension(),
        productAdvantages: []);
  }

  @override
  ProductDetails copyWith(
      {Product? product,
      Dimension? dimension,
      List<ProductAdvantages>? productAdvantages}) {
    return ProductDetails(
      product: product ?? this.product,
      selectedDimension: dimension ?? this.selectedDimension,
      productAdvantages: productAdvantages ?? this.productAdvantages,
    );
  }
}
