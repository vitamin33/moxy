// ignore: depend_on_referenced_packages
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_effects.dart';
import 'package:moxy/domain/mappers/media_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../utils/common.dart';
import 'new_product_list_state.dart';

class NewProductListCubit
    extends CubitWithEffects<NewProductListState, UiEffect> {
  NewProductListCubit()
      : super(NewProductListState.defaultNewProductListState()) {
    allSellingProduct();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final mediaMapper = locate<MediaMapper>();
  final profileRepository = locate<ProfileRepository>();

  void allSellingProduct() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getAllSellingProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        emit(state.copyWith(
            allSellingProduct: allProductsList));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });

      final resultMedia = await productRepository.fetchHomeMedia();
      resultMedia.when((success) {
        final mediaList = mediaMapper.mapToMedia(success);
        emit(state.copyWith(
          mediaList:mediaList,
             isLoading: false));
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
          state.allSellingProduct.firstWhere((it) => it.id == productId);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(allSellingProduct: state.allSellingProduct));
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
        emit(state.copyWith(allSellingProduct: state.allSellingProduct));
        emitEffect(ChangeFavoriteFailed());
      }
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }
}
