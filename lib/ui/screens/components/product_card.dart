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
    return SizedBox(
      width: 300,
      height: 350,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                product.dimensions.first.images.first.imagePath,
              ))),
              child: Padding(
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
                                color:
                                    isHovered ? AppTheme.gray : AppTheme.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(IconPath.favouritesWeb),
                            ),
                          );
                        },
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: theme.mediumSemiBoltText,
                  ),
                  Row(children: [
                    InkWell(
                        onTap: () {
                          context.push(
                              RouterProvider.producDetailsPath(product.id!));
                        },
                        child: Container(
                            width: 10, height: 10, color: AppTheme.green))
                  ]),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            context
                                .read<BasketCubit>()
                                .addProductToBasket(product);
                          },
                          child: SvgPicture.asset(IconPath.orders, width: 20)),
                      const SizedBox(width: 10),
                      Text(product.salePrice.toString()),
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
