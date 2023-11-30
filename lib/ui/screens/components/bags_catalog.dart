import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_card.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.isLoading
                ? const CircularProgressIndicator()
                : AlignedGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.bagsList.length,
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    itemBuilder: (context, index) {
                      final product = state.bagsList[index];
                      return ProductCard(
                        product: product,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
