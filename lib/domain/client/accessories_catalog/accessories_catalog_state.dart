import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class AccessoriesCatalogState implements Copyable<AccessoriesCatalogState> {
  final bool isLoading;
  final List<Product> accessoriesList;
  final String errorMessage;

  AccessoriesCatalogState({
    required this.isLoading,
    required this.accessoriesList,
    required this.errorMessage,
  });

  static defaultAccessoriesCatalogState() {
    return AccessoriesCatalogState(
      isLoading: false,
      accessoriesList: [Product.defaultProduct()],
      errorMessage: ''
    );
  }

  @override
  AccessoriesCatalogState copyWith({
    bool? isLoading,
    List<Product>? accessoriesList,
    String? errorMessage
  }) {
    return AccessoriesCatalogState(
      isLoading: isLoading ?? this.isLoading,
      accessoriesList: accessoriesList ?? this.accessoriesList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}