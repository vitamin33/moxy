import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/domain/client/favourites/favorites_effects.dart';
import 'package:moxy/domain/client/favourites/favourites_cubit.dart';
import 'package:moxy/domain/client/favourites/favourites_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 30.0),
                child: Text(
                  'Список бажань',
                  style: theme.headline3BoltText.copyWith(
                    color: AppTheme.black,
                  ),
                ),
              ),
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
          : buildFavoritesList(state),
    );
  }

  Widget buildFavoritesList(FavouritesState state) {
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
    bool isMobile = ResponsiveUtil.isMobile(context);
    final crossAxisExtent = isMobile ? 500.0 : 300.0;
    final spacing = isMobile
        ? AppTheme.defaultGridSpacingMobile
        : AppTheme.defaultGridSpacing;

    return AnimationLimiter(
      child: GridView.builder(
        itemCount: state.favoriteProducts.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 0.8,
          maxCrossAxisExtent: crossAxisExtent,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
        ),
        itemBuilder: (context, index) {
          Product product = state.favoriteProducts[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ProductCard(
                  product: product,
                  onChangeFavorites: (Product product) =>
                      _favouritesCubit.removeFromFavorites(product),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
