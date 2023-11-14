import 'package:flutter/material.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/constants.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteTap;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.dimensions.first.images.first.imagePath;
    final theme = AppTheme.of(context)!;
    return SizedBox(
      width: 200,
      height: 240,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 40,
            child: Container(
              clipBehavior: Clip.none,
              color: Colors.grey.withOpacity(0.1),
              height: 200,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  imageUrl,
                  height: 200,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(product.name.toUpperCase(),
                      style: theme.productItemText),
                  Text(
                    '${product.salePrice.toStringAsFixed(2)} $uah'
                        .toUpperCase(),
                    style: theme.productItemText,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Material(
              color: Colors.grey.withOpacity(0.1),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onFavoriteTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: AppTheme.pinkDark,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
