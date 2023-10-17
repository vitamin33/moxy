// ignore: depend_on_referenced_packages
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/favourites/favorites_effects.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'favourites_state.dart';

class FavouritesCubit extends CubitWithEffects<FavouritesState, UiEffect> {
  final profileRepository = locate<ProfileRepository>();

  FavouritesCubit() : super(FavouritesState.defaultState()) {
    getFavoriteProducts();
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
}
