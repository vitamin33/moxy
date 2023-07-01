import 'package:moxy/constant/product_colors.dart';
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
  List<String> images;
  String? editProductId;
  List<Dimension> allDimensions;

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
    required this.images,
    required this.editProductId,
    required this.errors,
    required this.allDimensions,
  });

  static CreateProductState defaultCreateProductState() {
    for (var element in allColorsDimens) {
      if (element.isSelected == true) {
        element.isSelected = false;
      }
    }
    return CreateProductState(
      isLoading: false,
      isEdit: false,
      isSuccess: false,
      errorMessage: '',
      editProduct: Product.defaultProduct(),
      initialPage: 0,
      activePage: 0,
      product: Product.defaultProduct(),
      images: [],
      editProductId: '',
      errors: FieldErrors(),
      allDimensions: allColorsDimens,
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
    List<String>? images,
    String? editProductId,
    FieldErrors? errors,
    List<Dimension>? allDimensions,
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
        images: images ?? this.images,
        editProductId: editProductId ?? this.editProductId,
        errors: errors ?? this.errors,
        allDimensions: allDimensions ?? this.allDimensions);
  }
}

class FieldErrors {
  FieldError? productName;
  FieldError? productDescription;
  FieldError? productIdName;
  FieldError? salePrice;
  FieldError? costPrice;
  FieldError? quantity;

  FieldErrors({
    this.productName,
    this.productDescription,
    this.productIdName,
    this.salePrice,
    this.costPrice,
    this.quantity,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (productName != null) {
      buffer.write('productName ');
    }
    if (productDescription != null) {
      buffer.write('productDescription ');
    }
    if (productIdName != null) {
      buffer.write('productIdName ');
    }
    if (costPrice != null) {
      buffer.write('costPrice ');
    }
    if (salePrice != null) {
      buffer.write('salePrice ');
    }
    if (quantity != null) {
      buffer.write('quantity ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
