import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class BagsCatalogCubit
    extends CubitWithEffects<BagsCatalogState, UiEffect> {
  BagsCatalogCubit()
      : super(BagsCatalogState.defaultBagsCatalogState()) {
    fetchBagsCatalog();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();

  void fetchBagsCatalog() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getBagsCatalog();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        emit(state.copyWith(
            bagsList: allProductsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void toggleFavoriteForProduct(String? productId) async {
    if (productId == null) {
      return;
    }
    try {
      Product product =
          state.bagsList.firstWhere((it) => it.id == productId);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(bagsList: state.bagsList));
      bool success;
      Result<bool, Exception> response;
      if (product.isFavorite) {
        response = await profileRepository.addFavoriteProduct(productId);
      } else {
        response = await profileRepository.removeFavoriteProduct(productId);
      }
      success = response.tryGetSuccess() ?? false;
      if (!success) {
        product.isFavorite = !product.isFavorite;
        emit(state.copyWith(bagsList: state.bagsList));
        emitEffect(ChangeFavoriteFailed());
      }
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }
}