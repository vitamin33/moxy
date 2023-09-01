import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class NewProductListState implements Copyable<NewProductListState> {
  final bool isLoading;
  final List<Product> allSellingProduct;
  final String errorMessage;

  NewProductListState({
    required this.isLoading,
    required this.allSellingProduct,
    required this.errorMessage,
  });

  static defaultNewProductListState() {
    return NewProductListState(
      isLoading: false,
      allSellingProduct: [Product.defaultProduct()],
      errorMessage: '',
    );
  }

  @override
  NewProductListState copyWith({
    bool? isLoading,
    List<Product>? allSellingProduct,
    String? errorMessage,
  }) {
    return NewProductListState(
      isLoading: isLoading ?? this.isLoading,
      allSellingProduct: allSellingProduct ?? this.allSellingProduct,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
