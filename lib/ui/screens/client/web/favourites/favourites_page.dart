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
import 'package:moxy/ui/screens/components/footer.dart';
import 'package:moxy/ui/profile_scope.dart';
import 'package:moxy/ui/screens/client/web/guest_profile.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    return BlocProvider<FavouritesCubit>(
      create: (BuildContext context) => _favouritesCubit,
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final profile = ProfileScope.of(context);

        return Scaffold(
          backgroundColor: AppTheme.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Список бажань',
                    style: theme.headline3BoltText.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                ),
                (profile != null && !profile.isGuest())
                    ? FavoritesContent(state: state, cubit: _favouritesCubit)
                    : const GuestProfileWidget(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: _buildFavoritesArea(state, isMobile),
                // ),
                const Footer()
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FavoritesContent extends StatelessWidget {
  final FavouritesState state;
  final FavouritesCubit cubit;
  const FavoritesContent({super.key, required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: state.isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: MoxyLoader(
                    iconSize: 40,
                  ),
                ),
              )
            : buildFavoritesList(state, isMobile, context));
  }

  Widget buildFavoritesList(
      FavouritesState state, bool isMobile, BuildContext context) {
    if (state.favoriteProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  height: 260,
                  width: 200,
                  child: Lottie.asset('assets/anim/empty_list.json')),
            ),
            const Text('Поки що список бажань пустий.'),
          ],
        ),
      );
    }
    bool isMobile = ResponsiveUtil.isMobile(context);
    // final crossAxisExtent = isMobile ? 500.0 : 300.0;
    // final spacing = isMobile
    //     ? AppTheme.defaultGridSpacingMobile
    //     : AppTheme.defaultGridSpacing;

    return AnimationLimiter(
        child: AlignedGridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.favoriteProducts.length,
      crossAxisCount: isMobile ? 2 : 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      itemBuilder: (context, index) {
        final product = state.favoriteProducts[index];
        return ProductCard(
          product: product,
          onChangeFavorites: cubit.removeFromFavorites,
        );
      },
    ));
  }
}
