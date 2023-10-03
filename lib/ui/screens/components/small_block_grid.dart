import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/models/product.dart';

import '../../../constant/icon_path.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class SmallBlockGrid extends StatelessWidget {
  final Product product;

  const SmallBlockGrid({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        product.dimensions.first.images.first.imagePath,
                      ))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {},
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
