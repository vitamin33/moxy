import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';

abstract mixin class FilterableCubit {
  void onApplyFilters(
      List<ProductColor> colors, List<FilterPrice> prices, List<SortBy> sortBy);

  List<Product> filterColorCatalog(
      String selectedColors, List<Product> originalList) {
    List<Product> filteredColorBagList = originalList
        .where((product) => product.dimensions
            .any((dimension) => dimension.color.name == selectedColors))
        .toList();
    return filteredColorBagList;
  }

  List<Product> filterPriceCatalog(
      String selectedPriceRange, List<Product> originalList) {
    List<Product> filteredPriceBagList = originalList.where((product) {
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
    return filteredPriceBagList;
  }

  List<Product> sortCatalogByCreateTime(
      String sortOrder, List<Product> originalList) {
    List<Product> sortedBagsList = List.from(originalList);

    if (sortOrder == 'New-Old') {
      sortedBagsList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    } else {
      sortedBagsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    }
    return sortedBagsList;
  }
}
