import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(String productId) onChangeFavorites;

  const ProductCard(
      {super.key, required this.product, required this.onChangeFavorites});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = ResponsiveUtil.isMobile(context);

    double cardWidth = isMobile ? screenWidth - 40 : 330;
    double cardHeight = isMobile ? 300 : 340;
    double itemPadding = isMobile ? 16 : 16;

    return OnHover(
      builder: (isCardHover) {
        return GestureDetector(
          onTap: () {
            context.push(RouterProvider.producDetailsPath(product.id!));
          },
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Padding(
              padding: isMobile
                  ? EdgeInsets.symmetric(
                      horizontal: itemPadding,
                      vertical: AppTheme.defaultPadding,
                    )
                  : EdgeInsets.all(itemPadding),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        _buildImageWithAnimation(isMobile, isCardHover),
                        _buildFavoriteIcon(context),
                        _buildAddBasketButton(context, theme, isCardHover)
                      ],
                    ),
                  ),
                  _buildProductInfoRow(context, theme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageWithAnimation(bool isMobile, bool isCardHover) {
    bool enableHover = isCardHover && !isMobile;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 1.0, end: enableHover ? 1.0 : 0.95),
      builder: (BuildContext context, double value, _) {
        return Transform.scale(
          scale: value,
          child: Center(
              child: (product.dimensions.first.images.isNotEmpty)
                  ? Image.network(
                      _currentImagePath(enableHover),
                    )
                  : Image.asset(
                      width: 50,
                      height: 50,
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    )),
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
    final isMobile = ResponsiveUtil.isMobile(context);
    final iconSize = isMobile ? AppTheme.iconSizeMobile : AppTheme.iconSize;
    final padding =
        isMobile ? AppTheme.defaultPaddingMobile : AppTheme.defaultPadding;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            onChangeFavorites(product.id!);
          },
          child: OnHover(
            builder: (isHovered) {
              return Container(
                  decoration: BoxDecoration(
                    color: isHovered ? AppTheme.greyLigth : AppTheme.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: product.isFavorite
                        ? SvgPicture.asset(
                            IconPath.favoriteProductFilledWeb,
                            width: iconSize,
                          )
                        : SvgPicture.asset(IconPath.favoriteProductWeb,
                            width: iconSize),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddBasketButton(
      BuildContext context, AppTheme theme, bool isCardHover) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final buttonSize =
        isMobile ? AppTheme.iconButtonSizeMobile : AppTheme.iconButtonSize;
    final padding =
        isMobile ? AppTheme.defaultPaddingMobile : AppTheme.defaultPadding;

    bool enableHover = isCardHover || isMobile;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      right: padding,
      bottom: enableHover ? padding : -50,
      child: GestureDetector(
        onTap: () {
          context.read<BasketCubit>().addProductToBasket(product);
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: enableHover ? 1.0 : 0.0,
          child: OnHover(builder: (isIconHover) {
            return Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(color: AppTheme.white, boxShadow: [
                  BoxShadow(
                    color: AppTheme.blackLight.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ]),
                child: AnimatedRotation(
                  turns: isIconHover ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.add,
                    color: AppTheme.blackLight,
                  ),
                ));
          }),
        ),
      ),
    );
  }

  Widget _buildProductInfoRow(BuildContext context, AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.name.toUpperCase(),
            style: theme.titleText,
          ),
          _buildPriceInfo(theme),
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
