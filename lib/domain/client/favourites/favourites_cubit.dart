// ignore: depend_on_referenced_packages
import 'package:moxy/config/routes.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/favourites/favorites_effects.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';
import 'favourites_state.dart';

class FavouritesCubit extends CubitWithEffects<FavouritesState, UiEffect> {
  final profileRepository = locate<ProfileRepository>();

  FavouritesCubit(RootRouterCubit navCubit)
      : super(FavouritesState.defaultState()) {
    initFavorites();
    navCubit.eventStream.listen((event) {
      if (event.routeName == Routes.favorites) {
        getFavoriteProducts();
      }
    });
  }

  void getFavoriteProducts() async {
    emit(state.copyWith(isLoading: true));
    final result = await profileRepository.getFavoriteProducts();
    result.when((products) {
      emit(state.copyWith(favoriteProducts: products, isLoading: false));
    }, (error) {
      emit(state.copyWith(isLoading: false));
      emitEffect(LoadingFailed());
    });
  }

  void removeFromFavorites(Product productId) async {
    try {
      state.favoriteProducts.removeWhere(
        (element) => element.id == productId.id,
      );
      emit(state.copyWith(favoriteProducts: state.favoriteProducts));
      Result<bool, Exception> response =
          await profileRepository.removeFavoriteProduct(productId.id!);
      bool success = response.tryGetSuccess() ?? false;
      if (!success) {
        emit(state.copyWith(favoriteProducts: state.favoriteProducts));
        emitEffect(RemoveFavoriteFailed());
      }
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }

  void initFavorites() async {
    if (state.favoriteProducts.isEmpty) {
      getFavoriteProducts();
    }
  }
}
