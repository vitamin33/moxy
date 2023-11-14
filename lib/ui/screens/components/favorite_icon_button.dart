import 'package:flutter/material.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FavoriteIconButton extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const FavoriteIconButton({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = product.isFavorite;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        fixedSize: const Size(25, 25),
      ),
      child: Icon(
        Icons.favorite,
        size: 15,
        color: isFavorite ? AppTheme.pinkDark : null,
      ),
    );
  }
}
