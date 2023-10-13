import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

import '../../validation_mixin.dart';

class ProductDetailsState implements Copyable<ProductDetailsState> {
  final bool isLoading;
  final String userEmail;
  final Product product;

  // field errors
  FieldErrors errors;

  ProductDetailsState({
    required this.isLoading,
    required this.userEmail,
    required this.errors,
    required this.product,
  });

  static defaultProductDetailsState() {
    return ProductDetailsState(
      isLoading: false,
      userEmail: '',
      errors: FieldErrors(),
      product: Product.defaultProduct(),
    );
  }

  @override
  ProductDetailsState copyWith(
      {String? userEmail,
      FieldErrors? errors,
      Product? product,
      bool? isLoading}) {
    return ProductDetailsState(
      isLoading: isLoading ?? this.isLoading,
      userEmail: userEmail ?? this.userEmail,
      errors: errors ?? this.errors,
      product: product ?? this.product,
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
