import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_state.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/filterable_cubit.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class AccessoriesCatalogCubit
    extends CubitWithEffects<AccessoriesCatalogState, UiEffect>
    with FilterableCubit {
  late List<Product> originalAccessoriesList;
  AccessoriesCatalogCubit()
      : super(AccessoriesCatalogState.defaultAccessoriesCatalogState()) {
    fetchAccessoriesCatalog();
    // getAttributesColorList();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();
  final configRepository = locate<ConfigRepository>();

  void fetchAccessoriesCatalog() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getAccessoriesCatalog();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        originalAccessoriesList = allProductsList;
        emit(
            state.copyWith(accessoriesList: allProductsList, isLoading: false));
      }, (error) {
        emitEffect(LoadingFailed());
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

// void getAttributesColorList() async {
//     try {
//       final colorList = await configRepository.getAttributesColorList();
//       emit(state.copyWith(attributes: colorList));
//     } catch (e) {
//       moxyPrint(e);
//     }
//   }

  void toggleFavoriteForProduct(String productId) async {
    try {
      Product product =
          state.accessoriesList.firstWhere((it) => it.id == productId);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(accessoriesList: state.accessoriesList));
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
        emit(state.copyWith(accessoriesList: state.accessoriesList));
        emitEffect(ChangeFavoriteFailed());
      }
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }

  @override
  void onApplyFilters(List<ProductColor> colors, List<FilterPrice> prices,
      List<SortBy> sortBy) {
    // TODO: implement reaction of change in this cubit, emit new state
  }
}
