import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class RecomendedProductState implements Copyable<RecomendedProductState> {
  final bool isLoading;
  final List<Product> recomendedProducts;
  final String errorMessage;

  RecomendedProductState({
    required this.isLoading,
    required this.recomendedProducts,
    required this.errorMessage,
  });

  static defaultRecomendedProductState() {
    return RecomendedProductState(
      isLoading: false,
      recomendedProducts: [Product.defaultProduct()],
      errorMessage: '',
    );
  }

  @override
  RecomendedProductState copyWith({
    bool? isLoading,
    List<Product>? recomendedProducts,
    String? errorMessage,
  }) {
    return RecomendedProductState(
      isLoading: isLoading ?? this.isLoading,
      recomendedProducts: recomendedProducts ?? this.recomendedProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}