import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/domain/catalog_filtering_mixin.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BagsCatalogCubit extends CubitWithEffects<BagsCatalogState, UiEffect>
    with CatalogsFilteringMixin {
  late List<Product> originalBagsList;
  late SharedPreferences prefs;

  BagsCatalogCubit() : super(BagsCatalogState.defaultBagsCatalogState()) {
    fetchBagsCatalog();
    getAttributesColorList();
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
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void getAttributesColorList() async {
    try {
      final colorList = await configRepository.getAttributesColorList();
      emit(state.copyWith(attributes: colorList));
    } catch (e) {
      moxyPrint(e);
    }
  }

  void toggleFavoriteForProduct(String? productId) async {
    if (productId == null) {
      return;
    }
    try {
      Product product = state.bagsList.firstWhere((it) => it.id == productId);
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

  void setFilterColor(String selectedColors) {
    final bagList = filterColorCatalog(selectedColors, originalBagsList);
    emit(state.copyWith(selectedColors: selectedColors, bagsList: bagList));
  }

  void setFilterPrice(String selectedPriceRange) {
    final bagList = filterPriceCatalog(selectedPriceRange, originalBagsList);
    emit(state.copyWith(
        selectedPriceRange: selectedPriceRange, bagsList: bagList));
  }

  void setFilterTime(String selectedTimeRange) {
    final bagList =
        sortCatalogByCreateTime(selectedTimeRange, originalBagsList);
    emit(state.copyWith(
        selectedTimeRange: selectedTimeRange, bagsList: bagList));
  }
}
