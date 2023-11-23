import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class RecomendedProductState implements Copyable<RecomendedProductState> {
  final bool isLoading;
  final List<Product> recomendedProducts;
  final String errorMessage;
  final int activePage;

  RecomendedProductState({
    required this.isLoading,
    required this.recomendedProducts,
    required this.errorMessage,
    required this.activePage,
  });

  static defaultRecomendedProductState() {
    return RecomendedProductState(
      isLoading: false,
      recomendedProducts: [Product.defaultProduct()],
      errorMessage: '',
      activePage: 0,
    );
  }

  @override
  RecomendedProductState copyWith({
    bool? isLoading,
    List<Product>? recomendedProducts,
    String? errorMessage,
    int? activePage,
  }) {
    return RecomendedProductState(
      isLoading: isLoading ?? this.isLoading,
      recomendedProducts: recomendedProducts ?? this.recomendedProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      activePage: activePage ?? this.activePage,
    );
  }
}