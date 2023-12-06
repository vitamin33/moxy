import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return OnHover(
      builder: (isCardHover) {
        return SizedBox(
          width: 330,
          height: 340,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _buildImageWithAnimation(isCardHover),
                    _buildFavoriteIcon(context),
                  ],
                ),
              ),
              _buildProductInfoRow(context, theme),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageWithAnimation(bool isCardHover) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 1.0, end: isCardHover ? 1.0 : 0.9),
      builder: (BuildContext context, double value, _) {
        return Transform.scale(
          scale: value,
          child: Image.network(
            _currentImagePath(isCardHover),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  String _currentImagePath(bool isCardHover) {
    return (product.dimensions.first.images.length < 2)
        ? product.dimensions.first.images[0].imagePath
        : isCardHover
            ? product.dimensions.first.images.first.imagePath
            : product.dimensions.first.images[1].imagePath;
  }

  Widget _buildFavoriteIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            context
                .read<BagsCatalogCubit>()
                .toggleFavoriteForProduct(product.id);
          },
          child: OnHover(
            builder: (isHovered) {
              return Container(
                decoration: BoxDecoration(
                  color: product.isFavorite
                      ? AppTheme.pinkDark
                      : isHovered
                          ? AppTheme.gray
                          : AppTheme.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(IconPath.favouritesWeb),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfoRow(BuildContext context, AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.name.toUpperCase(),
            style: theme.titleText,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.push(RouterProvider.producDetailsPath(product.id!));
                },
                child: SvgPicture.asset(IconPath.orders, width: 20),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  context.read<BasketCubit>().addProductToBasket(product);
                },
                child: SvgPicture.asset(IconPath.bagWeb, width: 15),
              ),
              const SizedBox(width: 10),
              _buildPriceInfo(theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(AppTheme theme) {
    return (product.discountPrice == 0)
        ? Text(
            '${product.salePrice.toString()}грн',
            style: theme.titleBoltText,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 15),
              Text(
                '${product.discountPrice}грн',
                style: theme.titleBoltText.copyWith(color: AppTheme.pinkDark),
              ),
              Text(
                '${product.salePrice.toString()}грн',
                style: theme.titleBoltText.copyWith(
                  color: AppTheme.gray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          );
  }
}
