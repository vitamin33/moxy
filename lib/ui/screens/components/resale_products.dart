import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_cubit.dart';
import 'package:moxy/domain/client/resale_product/resale_product_cubit.dart';
import 'package:moxy/domain/client/resale_product/resale_products_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ResaleProducts extends StatelessWidget {
  const ResaleProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResaleProductCubit(),
      child: BlocConsumer<ResaleProductCubit, ResaleProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<ResaleProductCubit>();
          final theme = AppTheme.of(context)!;

          return state.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Допродаж',
                        style: theme.headline4BoltText,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.moveToPreviousProduct();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.greyLigth,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: SvgPicture.asset(
                                  IconPath.backArrow,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 400,
                            width: 1050,
                            child: ListView.builder(
                              controller: cubit.scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.resaleProducts.length,
                              itemBuilder: (context, index) {
                                return RecomendedProductItem(
                                    product: state.resaleProducts[index]);
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.moveToNextProduct();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.greyLigth,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: SvgPicture.asset(
                                  IconPath.forwardArrow,
                                  width: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class RecomendedProductItem extends StatelessWidget {
  final Product product;

  const RecomendedProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: 300,
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
                        onTap: () {
                          context
                              .read<NewProductListCubit>()
                              .toggleFavoriteForProduct(product.id);
                        },
                        child: OnHover(
                          builder: (isHovered) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: isHovered
                                      ? AppTheme.gray
                                      : AppTheme.white,
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
                            child:
                                SvgPicture.asset(IconPath.orders, width: 20)),
                        const SizedBox(width: 10),
                        Text(product.salePrice.toString()),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
