import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';

abstract mixin class FilterableCubit {
  void onApplyFilters(
      List<ProductColor> colors, List<FilterPrice> prices, List<SortBy> sortBy);

  List<Product> filterColorCatalog(
      List<String> selectedColors, List<Product> originalList) {
    List<Product> filteredColorBagList = originalList
        .where((product) => product.dimensions
            .any((dimension) => selectedColors.contains(dimension.color.name)))
        .toList();
    return filteredColorBagList;
  }

  List<Product> filterPriceCatalog(
      List<String> selectedPriceRanges, List<Product> originalList) {
    List<Product> filteredPriceBagList = originalList.where((product) {
      double productPrice = product.salePrice;

      return selectedPriceRanges.any((selectedPriceRange) {
        List<String> priceRange = selectedPriceRange.split('-');

        if (priceRange.length == 2) {
          double minPrice = double.parse(priceRange[0]);
          double maxPrice = double.parse(priceRange[1]);

          return productPrice >= minPrice && productPrice <= maxPrice;
        }

        return false;
      });
    }).toList();

    return filteredPriceBagList;
  }

  List<Product> sortCatalogByCreateTime(
      List<String> sortOrder, List<Product> originalList) {
    List<Product> sortedBagsList = List.from(originalList);

    for (var order in sortOrder) {
      if (order == 'New-Old') {
        sortedBagsList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else {
        sortedBagsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      }
    }
    return sortedBagsList;
  }
}
