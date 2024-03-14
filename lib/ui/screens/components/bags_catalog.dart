import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/screens/components/shimmer/shimer_product.dart';
import 'package:moxy/utils/responsive_utils.dart';

class BagsCatalog extends StatefulWidget {
  const BagsCatalog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BagsCatalogState createState() => _BagsCatalogState();
}

class _BagsCatalogState extends State<BagsCatalog> {
  late BagsCatalogCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = context.read<BagsCatalogCubit>();

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
    return BlocBuilder<BagsCatalogCubit, BagsCatalogState>(
      builder: (context, state) {
        final isMobile = ResponsiveUtil.isMobile(context);
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: state.isLoading
                ? AlignedGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerProductCard();
                    },
                  )
                : AnimationLimiter(
                    child: AlignedGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.bagsList.length,
                      crossAxisCount: isMobile ? 1 : 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      itemBuilder: (context, index) {
                        final product = state.bagsList[index];
                        return ProductCard(
                          product: product,
                          onChangeFavorites: cubit.toggleFavoriteForProduct,
                        );
                      },
                    ),
                  ));
      },
    );
  }
}
