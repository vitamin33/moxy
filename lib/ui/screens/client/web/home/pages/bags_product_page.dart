import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_effect.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/client/web/basket/basket_page.dart';
import 'package:moxy/ui/screens/components/bags_catalog.dart';
import 'package:moxy/ui/screens/components/review_container.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/filter_container.dart';
import '../../../../components/footer.dart';
import '../../../../components/promo_container.dart';

class BagsProductPage extends StatefulWidget {
  const BagsProductPage({super.key});

  @override
  State<BagsProductPage> createState() => _BagsProductPageState();
}

class _BagsProductPageState extends State<BagsProductPage> {
  @override
  void initState() {
    super.initState();

    context.read<BasketCubit>().effectStream.listen((effect) {
      if (effect is OpenBasketSideSheet) {
        SideSheet.right(
            body: const BasketPage(),
            context: context,
            barrierColor: Colors.grey.withOpacity(0.5));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BagsCatalogCubit>(
        create: (context) => BagsCatalogCubit(),
        child: BlocBuilder<BagsCatalogCubit, BagsCatalogState>(
          builder: (context, state) {
            final cubit = context.read<BagsCatalogCubit>();
            return BlocBuilder<BasketCubit, BasketState>(
              builder: (context, basketState) {
                return Scaffold(
                  backgroundColor: AppTheme.white,
                  body: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FilterContainer(
                            title: 'Сумки',
                            productCount: state.bagsList.length.toString(),
                            selectedColors: state.selectedColors,
                            selectedPriceRange: state.selectedPriceRange,
                            selectedTimeRange: state.selectedTimeRange,
                            filterProductColors: state.attributes,
                            onChangedSelectedColors: cubit.setFilterColor,
                            onChangedSelectedPriceRange: cubit.setFilterPrice,
                            onChangedSelectedTimeRange: cubit.setFilterTime,
                          ),
                          const BagsCatalog(),
                          const PromoContainer(),
                          const ReviewContainer(),
                          const Footer(),
                        ],
                      ),
                    ),
                    if (basketState.isLoading)
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: LinearProgressIndicator(
                          color: AppTheme.pinkDark,
                          backgroundColor: AppTheme.pink,
                        ),
                      ),
                  ]),
                );
              },
            );
          },
        ));
  }
}
