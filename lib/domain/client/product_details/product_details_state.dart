import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';

import '../../validation_mixin.dart';

class ProductDetailsState implements Copyable<ProductDetailsState> {
  final bool isLoading;
  final String userEmail;
  final Product product;
  final BasketItem basketItem;

  // field errors
  FieldErrors errors;

  ProductDetailsState({
    required this.isLoading,
    required this.userEmail,
    required this.errors,
    required this.product,
    required this.basketItem,
  });

  static defaultProductDetailsState() {
    return ProductDetailsState(
      isLoading: false,
      userEmail: '',
      errors: FieldErrors(),
      product: Product.defaultProduct(),
      basketItem: BasketItem.defaultBasket(),
    );
  }

  @override
  ProductDetailsState copyWith(
      {String? userEmail,
      FieldErrors? errors,
      Product? product,
      bool? isLoading,
      BasketItem? basketItem,
      }) {
    return ProductDetailsState(
      isLoading: isLoading ?? this.isLoading,
      userEmail: userEmail ?? this.userEmail,
      errors: errors ?? this.errors,
      product: product ?? this.product,
      basketItem: basketItem ?? this.basketItem,
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
