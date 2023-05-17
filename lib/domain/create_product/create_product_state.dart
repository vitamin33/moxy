import 'package:flutter/foundation.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/validation_mixin.dart';

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
  String editProductId;

  // field errors
  FieldErrors errors;

  CreateProductState({
    required this.isLoading,
    required this.isEdit,
    required this.errorMessage,
    required this.editProduct,
    required this.initialPage,
    required this.activePage,
    required this.product,
    required this.images,
    required this.editProductId,
    required this.errors,
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
      editProductId: '',
      errors: FieldErrors(),
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
    String? editProductId,
    FieldErrors? errors,
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
      editProductId: editProductId ?? this.editProductId,
      errors: errors ?? this.errors,
    );
  }
}

class FieldErrors {
  FieldError? productName;
  FieldError? productDescription;
  FieldError? productIdName;
  FieldError? salePrice;
  FieldError? costPrice;
  FieldErrors({
    this.productName,
    this.productDescription,
    this.productIdName,
    this.salePrice,
    this.costPrice,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }
}
