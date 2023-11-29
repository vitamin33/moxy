import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class BagsCatalog extends StatefulWidget {
  const BagsCatalog({Key? key}) : super(key: key);

  @override
  _BagsCatalogState createState() => _BagsCatalogState();
}

class _BagsCatalogState extends State<BagsCatalog> {
  late BagsCatalogCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BagsCatalogCubit();

    cubit.effectStream.listen((effect) {
      if (effect is ChangeFavoriteFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Failed to change favorite state.'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<BagsCatalogCubit, BagsCatalogState>(
        builder: (context, state) {
          final theme = AppTheme.of(context)!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        height: 200,
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: state.bagsList.length,
                          itemBuilder: (context, index) {
                            final product = state.bagsList[index];

                            return SizedBox(
                              width: 200,
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                product.dimensions.first.images
                                                    .first.imagePath,
                                              ))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                cubit.toggleFavoriteForProduct(
                                                    product.id);
                                              },
                                              child: OnHover(
                                                builder: (isHovered) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: isHovered
                                                            ? AppTheme.gray
                                                            : AppTheme.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: SvgPicture.asset(
                                                          IconPath
                                                              .favouritesWeb),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product.name,
                                            style: theme.mediumSemiBoltText,
                                          ),
                                          Row(children: [
                                            InkWell(
                                                onTap: () {
                                                  context.push(RouterProvider
                                                      .producDetailsPath(
                                                          product.id!));
                                                },
                                                child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    color: AppTheme.green))
                                          ]),
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<BasketCubit>()
                                                        .addProductToBasket(
                                                            product);
                                                  },
                                                  child: SvgPicture.asset(
                                                      IconPath.orders,
                                                      width: 20)),
                                              const SizedBox(width: 10),
                                              Text(
                                                  product.salePrice.toString()),
                                            ],
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
