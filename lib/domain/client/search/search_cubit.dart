import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/search/search_effect.dart';
import 'package:moxy/domain/client/search/search_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class SearchCubit extends CubitWithEffects<SearchState, UiEffect>
    with ValidationMixin {
  late List<Product> originalProductList;
  SearchCubit() : super(SearchState.defaultSearchState()) {
    fetchAllProducts();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();

  void fetchAllProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getSearchProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        originalProductList = allProductsList;
        emit(state.copyWith(searchProduct: allProductsList, isLoading: false));
      }, (error) {
        moxyPrint('$error');
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void searchProduct(String value) {
    final searchProduct = originalProductList.where((element) {
      bool nameContainsValue =
          element.name.toLowerCase().contains(value.toLowerCase());

      bool descriptionContainsValue =
          element.description.toLowerCase().contains(value.toLowerCase());

      bool anyDimensionContainsValue = element.dimensions.any((dimension) {
        return dimension.color.name.toLowerCase().contains(value.toLowerCase());
      });

      return nameContainsValue ||
          descriptionContainsValue ||
          anyDimensionContainsValue;
    }).toList();

    emit(state.copyWith(searchProduct: searchProduct));
  }

  void toggleFavoriteForProduct(Product product) async {
    String? productId = product.id;
    if (productId == null) {
      return;
    }
    try {
      Product product =
          state.searchProduct.firstWhere((it) => it.id == productId);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(searchProduct: state.searchProduct));
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
        emit(state.copyWith(searchProduct: state.searchProduct));
        emitEffect(ChangeFavoriteFailed());
      }
      
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }
}
