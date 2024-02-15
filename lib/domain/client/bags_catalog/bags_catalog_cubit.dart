import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class BagsCatalogCubit extends CubitWithEffects<BagsCatalogState, UiEffect>
    with FilterableCubit {
  late List<Product> originalBagsList;
  late SharedPreferences prefs;

  BagsCatalogCubit() : super(BagsCatalogState.defaultBagsCatalogState()) {
    fetchBagsCatalog();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();
  final configRepository = locate<ConfigRepository>();

  void fetchBagsCatalog() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getBagsCatalog();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        originalBagsList = allProductsList;
        emit(state.copyWith(bagsList: allProductsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed allSellingProduct', isLoading: false));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void toggleFavoriteForProduct(Product productId) async {
    try {
      Product product =
          state.bagsList.firstWhere((it) => it.id == productId.id);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(bagsList: state.bagsList));
      bool success;
      Result<bool, Exception> response;
      if (product.isFavorite) {
        response = await profileRepository.addFavoriteProduct(productId.id!);
      } else {
        response = await profileRepository.removeFavoriteProduct(productId.id!);
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

  @override
  void onApplyFilters(List<ProductColor> colors, List<FilterPrice> prices,
      List<SortBy> sortBy) {
    try {
      List<Product> updatedBagList = List.from(originalBagsList);

      List<String> selectedColor = [];
      List<String> selectedPrice = [];
      List<String> selectedSortBy = [];
      for (var color in colors) {
        if (color.isSelected) {
          selectedColor.add(color.name);
        }
      }
      for (var price in prices) {
        if (price.isSelected) {
          selectedPrice.add(price.name);
        }
      }
      for (var time in sortBy) {
        if (time.isSelected) {
          selectedSortBy.add(time.name);
        }
      }

      if (selectedColor.isNotEmpty) {
        updatedBagList = filterColorCatalog(selectedColor, updatedBagList);
      }

      if (selectedPrice.isNotEmpty) {
        updatedBagList = filterPriceCatalog(selectedPrice, updatedBagList);
      }

      if (selectedSortBy.isNotEmpty) {
        updatedBagList =
            sortCatalogByCreateTime(selectedSortBy, updatedBagList);
      }

      emit(state.copyWith(bagsList: updatedBagList));
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }
}
