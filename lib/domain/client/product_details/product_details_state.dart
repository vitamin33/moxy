import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product_details.dart';

import '../../validation_mixin.dart';

class ProductDetailsState implements Copyable<ProductDetailsState> {
  final bool isLoading;
  final ProductDetails productDetails;
  FieldErrors errors;

  ProductDetailsState({
    required this.isLoading,
    required this.errors,
    required this.productDetails,
  });

  static defaultProductDetailsState() {
    return ProductDetailsState(
      isLoading: false,
      errors: FieldErrors(),
      productDetails: ProductDetails.defaultProductDetails(),
    );
  }

  @override
  ProductDetailsState copyWith({
    FieldErrors? errors,
    bool? isLoading,
    ProductDetails? productDetails
  }) {
    return ProductDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}

class FieldErrors {
  FieldError? emailUser;

  FieldErrors({
    this.emailUser,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (emailUser != null) {
      buffer.write('emailUser ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
