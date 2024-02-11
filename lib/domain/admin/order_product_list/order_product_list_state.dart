import 'package:moxy/domain/models/dimension_product.dart';

import '../../copyable.dart';
import '../../models/order.dart';
import '../../models/product.dart';

class OrderProductListState implements Copyable<OrderProductListState> {
  final List<DimensionProduct> productsByDimension;
  final List<DimensionProduct> searchProductsByDimension;
  final bool isLoading;
  final bool isEdit;
  final String? searchText;
  final String? errorMessage;
  final List<Product> allProducts;
  Set<OrderedItem> selectedProducts = {};

  OrderProductListState({
    required this.productsByDimension,
    required this.searchProductsByDimension,
    required this.allProducts,
    required this.isLoading,
    required this.selectedProducts,
    required this.searchText,
    this.isEdit = false,
    this.errorMessage,
  });

  static OrderProductListState defaultAllProductsState() {
    return OrderProductListState(
      productsByDimension: [],
      searchProductsByDimension: [],
      allProducts: [],
      selectedProducts: {},
      isLoading: false,
      isEdit: false,
      errorMessage: '',
      searchText: '',
    );
  }

  @override
  OrderProductListState copyWith({
    bool? isLoading,
    bool? isEdit,
    String? searchText,
    String? errorMessage,
    List<Product>? allProducts,
    List<DimensionProduct>? productsByDimension,
    List<DimensionProduct>? searchProductsByDimension,
    Set<OrderedItem>? selectedProducts,
  }) {
    return OrderProductListState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage ?? this.errorMessage,
      productsByDimension: productsByDimension ?? this.productsByDimension,
      searchProductsByDimension:
          searchProductsByDimension ?? this.searchProductsByDimension,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      allProducts: allProducts ?? this.allProducts,
    );
  }

  bool isSearching() {
    return !(searchText == null || searchText!.isEmpty);
  }
}
