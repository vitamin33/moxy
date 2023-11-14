import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/domain/client/favourites/favorites_effects.dart';
import 'package:moxy/domain/client/favourites/favourites_cubit.dart';
import 'package:moxy/domain/client/favourites/favourites_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_grid_item.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late FavouritesCubit _favouritesCubit;

  @override
  void initState() {
    super.initState();
    _favouritesCubit = FavouritesCubit();
    _favouritesCubit.effectStream.listen((effect) {
      if (effect is LoadingFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                'Failed to load favorite products. Try later.'));
      }
      if (effect is RemoveFavoriteFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Failed to remove from favorite products.'));
      }
    });
  }

  @override
  void dispose() {
    _favouritesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return BlocProvider<FavouritesCubit>(
      create: (BuildContext context) => _favouritesCubit,
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Список бажань',
                  style: theme.mainTitleText.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: _buildFavoritesArea(state),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesArea(FavouritesState state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: state.isLoading
          ? const MoxyLoader(
              iconSize: 40,
            )
          : _buildFavoritesList(state),
    );
  }

  Widget _buildFavoritesList(FavouritesState state) {
    if (state.favoriteProducts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 260,
              width: 200,
              child: Lottie.asset('assets/anim/empty_list.json')),
          const Text('Поки що список бажань пустий.'),
        ],
      );
    }
    return GridView.builder(
      itemCount: state.favoriteProducts.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.8,
        maxCrossAxisExtent: 240.0,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (context, index) {
        Product product = state.favoriteProducts[index];
        return ProductGridItem(
          product: product,
          onFavoriteTap: () => _favouritesCubit.removeFromFavorites(product),
        );
      },
    );
  }
}
