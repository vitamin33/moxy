import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/domain/client/favourites/favorites_effects.dart';
import 'package:moxy/domain/client/favourites/favourites_cubit.dart';
import 'package:moxy/domain/client/favourites/favourites_state.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

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
    final navCubit = context.read<RootRouterCubit>();
    _favouritesCubit = FavouritesCubit(navCubit);
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
          final isMobile = ResponsiveUtil.isMobile(context);
          return Scaffold(
            backgroundColor: AppTheme.white,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Список бажань',
                    style: theme.headline3BoltText.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                   const SizedBox(height: 32),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: _buildFavoritesArea(state, isMobile),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesArea(FavouritesState state, bool isMobile) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: state.isLoading
          ? const MoxyLoader(
              iconSize: 40,
            )
          : buildFavoritesList(state, isMobile),
    );
  }

  Widget buildFavoritesList(FavouritesState state, bool isMobile) {
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
    return AnimationLimiter(
        child: AlignedGridView.count(
      itemCount: state.favoriteProducts.length,
      crossAxisCount: isMobile ? 1 : 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      itemBuilder: (context, index) {
        final product = state.favoriteProducts[index];
        return ProductCard(
          product: product,
          onChangeFavorites: _favouritesCubit.removeFromFavorites,
        );
      },
    ));
  }
}
