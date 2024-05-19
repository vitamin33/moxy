import 'package:moxy/constant/place_production.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/validation_mixin.dart';

import '../../copyable.dart';

class CreateProductState implements Copyable<CreateProductState> {
  bool isLoading;
  bool isEdit;
  bool isSuccess;
  String errorMessage;
  Product editProduct;
  int initialPage;
  int activePage;
  Product product;
  String? editProductId;
  List<ProductColor> allConfigColors;
  List<String> productCategories;
  PlaceProduction placeProduction;

  // field errors
  FieldErrors errors;

  CreateProductState({
    required this.isLoading,
    required this.isEdit,
    required this.isSuccess,
    required this.errorMessage,
    required this.editProduct,
    required this.initialPage,
    required this.activePage,
    required this.product,
    required this.editProductId,
    required this.errors,
    required this.allConfigColors,
    required this.productCategories,
    required this.placeProduction,
  });

  static CreateProductState defaultCreateProductState() {
    return CreateProductState(
      isLoading: false,
      isEdit: false,
      isSuccess: false,
      errorMessage: '',
      editProduct: Product.defaultProduct(),
      initialPage: 0,
      activePage: 0,
      product: Product.defaultProduct(),
      editProductId: '',
      errors: FieldErrors(),
      allConfigColors: [],
      productCategories: [],
      placeProduction: PlaceProduction.china,
    );
  }

  @override
  CreateProductState copyWith({
    bool? isLoading,
    bool? isEdit,
    bool? isSuccess,
    String? errorMessage,
    Product? editProduct,
    int? initialPage,
    int? activePage,
    Product? product,
    String? editProductId,
    FieldErrors? errors,
    List<ProductColor>? allConfigColors,
    List<String>? productCategories,
    PlaceProduction? placeProduction,
  }) {
    return CreateProductState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      editProduct: editProduct ?? this.editProduct,
      initialPage: initialPage ?? this.initialPage,
      activePage: activePage ?? this.activePage,
      product: product ?? this.product,
      editProductId: editProductId ?? this.editProductId,
      errors: errors ?? this.errors,
      allConfigColors: allConfigColors ?? this.allConfigColors,
      productCategories: productCategories ?? this.productCategories,
      placeProduction: placeProduction ?? this.placeProduction,
    );
  }
}

class FieldErrors {
  FieldError? productName;
  FieldError? productDescription;
  FieldError? productIdName;
  FieldError? salePrice;
  FieldError? costPriceInUsd;
  FieldError? costPrice;
  FieldError? weightInGrams;
  FieldError? weightInCm;
  FieldError? heightInCm;
  FieldError? widthInCm;
  FieldError? lengthInCm;
  FieldError? dimensions;

  FieldErrors({
    this.productName,
    this.productDescription,
    this.productIdName,
    this.salePrice,
    this.costPriceInUsd,
    this.costPrice,
    this.weightInGrams,
    this.heightInCm,
    this.widthInCm,
    this.lengthInCm,
    this.dimensions,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (productName != null ) {
      buffer.write('productName ');
    }
    if (productDescription != null) {
      buffer.write('productDescription ');
    }
    if (productIdName != null) {
      buffer.write('productIdName ');
    }
    if (costPriceInUsd != null) {
      buffer.write('costPriceInUsd ');
    }
    if (costPrice != null) {
      buffer.write('costPrice ');
    }
    if (weightInGrams != null) {
      buffer.write('weightInGrams ');
    }
    if (heightInCm != null) {
      buffer.write('heightInCm ');
    }
    if (widthInCm != null) {
      buffer.write('widthInCm ');
    }
    if (lengthInCm != null) {
      buffer.write('lengthInCm ');
    }
    if (salePrice != null) {
      buffer.write('salePrice ');
    }
    if (dimensions != null) {
      buffer.write('wrong dimensions ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
