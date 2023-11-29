
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class BagsCatalogState implements Copyable<BagsCatalogState> {
  final bool isLoading;
  final List<Product> bagsList;
  final String errorMessage;

  BagsCatalogState({
    required this.isLoading,
    required this.bagsList,
    required this.errorMessage,
  });

  static defaultBagsCatalogState() {
    return BagsCatalogState(
      isLoading: false,
      bagsList: [Product.defaultProduct()],
      errorMessage: ''
    );
  }

  @override
  BagsCatalogState copyWith({
    bool? isLoading,
    List<Product>? bagsList,
    String? errorMessage
  }) {
    return BagsCatalogState(
      isLoading: isLoading ?? this.isLoading,
      bagsList: bagsList ?? this.bagsList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}