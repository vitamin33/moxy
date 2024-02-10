import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_state.dart';
import 'package:moxy/domain/filterable_cubit.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class FilterCatalogCubit extends Cubit<FilterCatalogState> {
  final FilterableCubit parentCubit;
  FilterCatalogCubit({required this.parentCubit})
      : super(FilterCatalogState.defaultFilterCatalogState()) {
    getAttributes();
  }

  final configRepository = locate<ConfigRepository>();

  void getAttributes() async {
    try {
      final attributes = await configRepository.getSharedAttributes();
      emit(state.copyWith(filterColors: attributes.colors));
    } catch (e) {
      moxyPrint(e);
    }
  }

  void onApplyFilters(List<ProductColor> colors, List<FilterPrice> prices,
      List<SortBy> sortBy) {
    emit(state.copyWith(
        filterColors: colors, filterPrice: prices, sortBy: sortBy));
    parentCubit.onApplyFilters(
        state.filterColors, state.filterPrice, state.sortBy);
  }

  void onChangeFilterColor(String selectedColorName) {
    final updateColors =
        selectedAttributesColor(selectedColorName, state.filterColors);

    emit(state.copyWith(filterColors: updateColors));
    parentCubit.onApplyFilters(
        state.filterColors, state.filterPrice, state.sortBy);
  }

  List<ProductColor> selectedAttributesColor(
      String selectedColorName, List<ProductColor> attributesColor) {
    return attributesColor
        .map((color) {
          if (color.name == selectedColorName) {
            return ProductColor(
                id: color.id,
                name: color.name,
                hexCode: color.hexCode,
                isSelected: !color.isSelected);
          } else {
            return color;
          }
        })
        .whereType<ProductColor>()
        .toList();
  }

  void onChangeFilterPrice(String selectedPriceRange) {
    // final bagList = filterPriceCatalog(selectedPriceRange, originalBagsList);
    final updateFilterPrice =
        selectedFilterPrice(selectedPriceRange, state.filterPrice);
    emit(state.copyWith(
        // bagsList: bagList,
        filterPrice: updateFilterPrice));
    parentCubit.onApplyFilters(
        state.filterColors, state.filterPrice, state.sortBy);
  }

  List<FilterPrice> selectedFilterPrice(
      String selectedPriceRange, List<FilterPrice> filterPrice) {
    return filterPrice
        .map((price) {
          if (price.name == selectedPriceRange) {
            return FilterPrice(name: price.name, isSelected: !price.isSelected);
          } else {
            return price;
          }
        })
        .whereType<FilterPrice>()
        .toList();
  }

  void onChangeFilterTime(String selectedTimeRange) {
    // final bagList =
    //     sortCatalogByCreateTime(selectedTimeRange, originalBagsList);
    final updateSortBy = selectedSortBy(selectedTimeRange, state.sortBy);
    emit(state.copyWith(
        // bagsList: bagList,
        sortBy: updateSortBy));
    parentCubit.onApplyFilters(
        state.filterColors, state.filterPrice, state.sortBy);
  }

  List<SortBy> selectedSortBy(String selectedTimeRange, List<SortBy> sortTime) {
    return sortTime
        .map((time) {
          if (time.name == selectedTimeRange) {
            return SortBy(name: time.name, isSelected: !time.isSelected);
          } else {
            return time;
          }
        })
        .whereType<SortBy>()
        .toList();
  }
}
