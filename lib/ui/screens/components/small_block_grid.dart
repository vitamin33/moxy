import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/product_card.dart';

class SmallBlockGrid extends StatelessWidget {
  final Product product;

  const SmallBlockGrid({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    NewProductListCubit cubit = context.read<NewProductListCubit>();
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: ProductCard(
        product: product,
        onChangeFavorites: cubit.toggleFavoriteForProduct,
      ),
    );
  }
}
