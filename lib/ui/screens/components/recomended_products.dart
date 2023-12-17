import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/recomended_product/recomended_product_cubit.dart';
import 'package:moxy/domain/client/recomended_product/recomended_products_state.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class RecomendedProducts extends StatelessWidget {
  const RecomendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecomendedProductCubit(),
      child: BlocConsumer<RecomendedProductCubit, RecomendedProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<RecomendedProductCubit>();
          final theme = AppTheme.of(context)!;

          return state.isLoading
              ? const CircularProgressIndicator()
              : Column(
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
                              itemCount: state.recomendedProducts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ProductCard(
                                      product: state.recomendedProducts[index]),
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
                );
        },
      ),
    );
  }
}
