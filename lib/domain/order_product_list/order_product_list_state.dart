import '../copyable.dart';
import '../models/product.dart';

class OrderProductListState implements Copyable<OrderProductListState> {
  final Map<String, List<Product>> productsByColor;
  final bool isLoading;
  final String? errorMessage;
  final List<Product> allProducts;

  OrderProductListState({
    required this.productsByColor,
    required this.allProducts,
    required this.isLoading,
    this.errorMessage,
  });

  static OrderProductListState defaultAllProductsState() {
    return OrderProductListState(
      productsByColor: {},
      allProducts: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  OrderProductListState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Product>? allProducts,
    Map<String, List<Product>>? productsByColor,
  }) {
    return OrderProductListState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      productsByColor: productsByColor ?? this.productsByColor,
      allProducts: allProducts ?? this.allProducts,
    );
  }
}