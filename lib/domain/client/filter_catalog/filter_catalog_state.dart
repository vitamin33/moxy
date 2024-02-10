import 'package:moxy/constant/filter_catalog.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/attributes.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';

class FilterCatalogState implements Copyable<FilterCatalogState> {
  final bool isLoading;
  final List<ProductColor> filterColors;
  final List<FilterPrice> filterPrice;
  final List<SortBy> sortBy;

  FilterCatalogState({
    required this.isLoading,
    required this.filterColors,
    required this.filterPrice,
    required this.sortBy,
  });

  static defaultFilterCatalogState() {
    return FilterCatalogState(
      isLoading: false,
      filterColors: Attributes.defaultAttributes().colors,
      filterPrice: filterRangePrice,
      sortBy: filterTime,
    );
  }

  @override
  FilterCatalogState copyWith({
    bool? isLoading,
    List<ProductColor>? filterColors,
    List<FilterPrice>? filterPrice,
    List<SortBy>? sortBy,
  }) {
    return FilterCatalogState(
      isLoading: isLoading ?? this.isLoading,
      filterColors: filterColors ?? this.filterColors,
      filterPrice: filterPrice ?? this.filterPrice,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
