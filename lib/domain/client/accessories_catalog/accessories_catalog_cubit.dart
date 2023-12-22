import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_state.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_effect.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class AccessoriesCatalogCubit
    extends CubitWithEffects<AccessoriesCatalogState, UiEffect> {
  late List<Product> originalAccessoriesList;
  AccessoriesCatalogCubit()
      : super(AccessoriesCatalogState.defaultAccessoriesCatalogState()) {
    fetchAccessoriesCatalog();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();

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

  void toggleFavoriteForProduct(String? productId) async {
    if (productId == null) {
      return;
    }
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

  void setFilterPrice(String selectedPriceRange) {
    emit(state.copyWith(selectedPriceRange: selectedPriceRange));
    filterPriceCatalog(selectedPriceRange);
  }

  void setFilterTime(String selectedTimeRange) {
    emit(state.copyWith(selectedTimeRange: selectedTimeRange));
    sortCatalogByCreateTime(selectedTimeRange);
  }

  void filterColorCatalog(String selectedColors) {
    List<Product> filteredColorBagList = originalAccessoriesList
        .where((product) => product.dimensions
            .any((dimension) => dimension.color.name == selectedColors))
        .toList();
    emit(state.copyWith(accessoriesList: filteredColorBagList));
  }

  void filterPriceCatalog(String selectedPriceRange) {
    List<Product> filteredPriceBagList = originalAccessoriesList.where((product) {
      List<String> priceRange = selectedPriceRange.split('-');

      if (priceRange.length == 2) {
        double minPrice = double.parse(priceRange[0]);
        double maxPrice = double.parse(priceRange[1]);
        double productPrice = product.salePrice;
        return productPrice >= minPrice && productPrice <= maxPrice;
      } else {
        return true;
      }
    }).toList();

    emit(state.copyWith(accessoriesList: filteredPriceBagList));
  }

  void sortCatalogByCreateTime(String sortOrder) {
    List<Product> sortedBagsList = List.from(originalAccessoriesList);

    if (sortOrder == 'New-Old') {
      sortedBagsList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    } else {
      sortedBagsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    }

    emit(state.copyWith(accessoriesList: sortedBagsList));
  }
}
