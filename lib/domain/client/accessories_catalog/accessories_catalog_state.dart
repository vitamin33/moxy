import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class AccessoriesCatalogState implements Copyable<AccessoriesCatalogState> {
  final bool isLoading;
  final List<Product> accessoriesList;

  AccessoriesCatalogState({
    required this.isLoading,
    required this.accessoriesList,
  });

  static defaultAccessoriesCatalogState() {
    return AccessoriesCatalogState(
      isLoading: false,
      accessoriesList: [Product.defaultProduct()],
    );
  }

  @override
  AccessoriesCatalogState copyWith({
    bool? isLoading,
    List<Product>? accessoriesList,
  }) {
    return AccessoriesCatalogState(
      isLoading: isLoading ?? this.isLoading,
      accessoriesList: accessoriesList ?? this.accessoriesList,
    );
  }
}