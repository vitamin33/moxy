import 'package:moxy/constant/filter_catalog.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/attributes.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/sort_by.dart';

class FilterCatalogState implements Copyable<FilterCatalogState> {
  final bool isLoading;
  final Attributes attributes;
   final List<FilterPrice> filterPrice;
  final List<SortBy> sortBy;

  FilterCatalogState({
    required this.isLoading,
    required this.attributes,
    required this.filterPrice,
    required this.sortBy,
  });

  static defaultFilterCatalogState() {
    return FilterCatalogState(
      isLoading: false,
      attributes: Attributes.defaultAttributes(),
      filterPrice: filterRangePrice,
      sortBy: filterTime,
    );
  }

  @override
  FilterCatalogState copyWith({
    bool? isLoading,
    Attributes? attributes,
     List<FilterPrice>? filterPrice,
    List<SortBy>? sortBy,
  }) {
    return FilterCatalogState(
      isLoading: isLoading ?? this.isLoading,
      attributes: attributes ?? this.attributes,
      filterPrice: filterPrice ?? this.filterPrice,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
