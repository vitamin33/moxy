import 'package:flutter/foundation.dart';
import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';

class CreateProductState implements Copyable<CreateProductState> {
  bool isLoading;
  bool isEdit;
  String errorMessage;
  Product editProduct;
  int initialPage;
  int activePage;
  Product product;
  List<String> images;
  CreateProductState({
    required this.isLoading,
    required this.isEdit,
    required this.errorMessage,
    required this.editProduct,
    required this.initialPage,
    required this.activePage,
    required this.product,
    required this.images,
  });

  static CreateProductState defaultCreateProductState() {
    return CreateProductState(
      isLoading: false,
      isEdit: false,
      errorMessage: '',
      editProduct: Product.defaultProduct(),
      initialPage: 0,
      activePage: 0,
      product: Product.defaultProduct(),
      images: [],
    );
  }

  @override
  CreateProductState copyWith({
    bool? isLoading,
    bool? isEdit,
    String? errorMessage,
    Product? editProduct,
    int? initialPage,
    int? activePage,
    Product? product,
    List<String>? images,
    List<Dimension>? dimensions,
  }) {
    return CreateProductState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      errorMessage: errorMessage ?? this.errorMessage,
      editProduct: editProduct ?? this.editProduct,
      initialPage: initialPage ?? this.initialPage,
      activePage: activePage ?? this.activePage,
      product: product ?? this.product,
      images: images ?? this.images,
    );
  }
}
