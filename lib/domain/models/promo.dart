import 'package:moxy/domain/models/product.dart';

class Promo {
  final String imageUrl;
  final int discount;
  final String title;
  final String productId;
  final Product? product;
  final String? finalDate;

  Promo({
    required this.imageUrl,
    required this.discount,
    required this.title,
    required this.productId,
    this.product,
    this.finalDate,
  });

  static Promo defaultPromo() {
    return Promo(
        imageUrl: '',
        discount: 0,
        title: '',
        productId: '',
        product: null,
        finalDate: '');
  }

  Promo copyWith({
    String? imageUrl,
    int? discount,
    String? title,
    String? productId,
    Product? product,
    String? finalDate,
  }) {
    return Promo(
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      title: title ?? this.title,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      finalDate: finalDate ?? this.finalDate,
    );
  }
}
