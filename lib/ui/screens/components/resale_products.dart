import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/resale_product/resale_product_cubit.dart';
import 'package:moxy/domain/client/resale_product/resale_products_state.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
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
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
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
                        height: 350,
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
                            Expanded(
                              child: ListView.builder(
                                controller: cubit.scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.resaleProducts.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductCard(
                                      product: state.resaleProducts[index],
                                      onChangeFavorites:
                                          cubit.toggleFavoriteForProduct,
                                    ),
                                  );
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
                  ),
                );
        },
      ),
    );
  }
}
