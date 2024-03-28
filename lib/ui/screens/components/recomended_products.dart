import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/recomended_product/recomended_product_cubit.dart';
import 'package:moxy/domain/client/recomended_product/recomended_products_state.dart';
import 'package:moxy/ui/screens/components/lottie_loader.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/screens/components/shimmer/shimmer_horizontal_list.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class RecomendedProducts extends StatelessWidget {
  const RecomendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecomendedProductCubit(),
      child: BlocConsumer<RecomendedProductCubit, RecomendedProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.isLoading) {
            return const ShimmerHorizontalList();
          }

          final cubit = context.read<RecomendedProductCubit>();
          final theme = AppTheme.of(context)!;
          final isMobile = ResponsiveUtil.isMobile(context);

          return state.isLoading
              ? LottieLoader()
              : Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Вам може сподобатись',
                          style: theme.headline4BoltText,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.moveToPreviousProduct(isMobile);
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
                            Expanded(
                              child: isMobile
                                  ? PageView.builder(
                                      controller: cubit.pageController,
                                      itemCount:
                                          state.recomendedProducts.length,
                                      itemBuilder: (context, index) {
                                        return ProductCard(
                                          product:
                                              state.recomendedProducts[index],
                                          onChangeFavorites:
                                              cubit.toggleFavoriteForProduct,
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      controller: cubit.scrollController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.recomendedProducts.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ProductCard(
                                            product:
                                                state.recomendedProducts[index],
                                            onChangeFavorites:
                                                cubit.toggleFavoriteForProduct,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.moveToNextProduct(isMobile);
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
                  ),
                );
        },
      ),
    );
  }
}
