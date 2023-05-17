import 'package:flutter/foundation.dart';

import '../copyable.dart';
import '../models/product.dart';

class AllProductsState implements Copyable<AllProductsState> {
  final List<Product> allProducts;
  final bool isLoading;
  final String? errorMessage;

  AllProductsState({
    required this.allProducts,
    required this.isLoading,
    this.errorMessage,
  });

  static AllProductsState defaultAllProductsState() {
    return AllProductsState(
      allProducts: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  AllProductsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Product>? allProducts,
  }) {
    return AllProductsState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        allProducts: allProducts ?? this.allProducts);
  }
}
