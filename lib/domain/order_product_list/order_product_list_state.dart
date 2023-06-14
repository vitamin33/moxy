import '../copyable.dart';
import '../models/product.dart';

class OrderProductListState implements Copyable<OrderProductListState> {
  final Map<String, List<Product>> productsByColor;
  final bool isLoading;
  final bool isEdit;
  final String? errorMessage;
  final List<Product> allProducts;

  OrderProductListState({
    required this.productsByColor,
    required this.allProducts,
    required this.isLoading,
    this.isEdit=false,
    this.errorMessage,
  });

  static OrderProductListState defaultAllProductsState() {
    return OrderProductListState(
      productsByColor: {},
      allProducts: [],
      isLoading: false,
      isEdit: false,
      errorMessage: '',
    );
  }

  @override
  OrderProductListState copyWith({
    bool? isLoading,
    bool? isEdit,
    String? errorMessage,
    List<Product>? allProducts,
    Map<String, List<Product>>? productsByColor,
  }) {
    return OrderProductListState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      errorMessage: errorMessage ?? this.errorMessage,
      productsByColor: productsByColor ?? this.productsByColor,
      allProducts: allProducts ?? this.allProducts,
    );
  }
}
