import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_cubit.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_effect.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/lottie_loader.dart';
import 'package:moxy/ui/screens/components/product_card.dart';

class AccessoriesCatalog extends StatefulWidget {
  const AccessoriesCatalog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccessoriesCatalogState createState() => _AccessoriesCatalogState();
}

class _AccessoriesCatalogState extends State<AccessoriesCatalog> {
  late AccessoriesCatalogCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AccessoriesCatalogCubit();

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
    return BlocBuilder<AccessoriesCatalogCubit, AccessoriesCatalogState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.isLoading
              ?  LottieLoader()
              : AlignedGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.accessoriesList.length,
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    final product = state.accessoriesList[index];
                    return ProductCard(
                      product: product,
                      onChangeFavorites: cubit.toggleFavoriteForProduct,
                    );
                  },
                ),
        );
      },
    );
  }
}
