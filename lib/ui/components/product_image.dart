import 'package:flutter/material.dart';
import 'package:moxy/domain/models/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final int size;
  const ProductImage({
    super.key,
    required this.product,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    if (product.dimensions.first.images.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: product.dimensions.first.images.first.imagePath,
        width: size.toDouble(),
        height: size.toDouble(),
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        width: size.toDouble(),
        height: size.toDouble(),
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}
