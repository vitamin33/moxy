import '../../copyable.dart';
import '../../models/order.dart';
import '../../models/product.dart';

class OrderProductListState implements Copyable<OrderProductListState> {
  final Map<String, Product> productByColor;
  final bool isLoading;
  final bool isEdit;
  final String? errorMessage;
  final List<Product> allProducts;
  Set<OrderedItem> selectedProducts = {};

  OrderProductListState({
    required this.productByColor,
    required this.allProducts,
    required this.isLoading,
    required this.selectedProducts,
    this.isEdit = false,
    this.errorMessage,
  });

  static OrderProductListState defaultAllProductsState() {
    return OrderProductListState(
      productByColor: {},
      allProducts: [],
      selectedProducts: {},
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
    Map<String, Product>? productByColor,
    Set<OrderedItem>? selectedProducts,
  }) {
    return OrderProductListState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      errorMessage: errorMessage ?? this.errorMessage,
      productByColor: productByColor ?? this.productByColor,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      allProducts: allProducts ?? this.allProducts,
    );
  }
}
