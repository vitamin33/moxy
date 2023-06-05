import 'package:moxy/domain/models/product.dart';

import '../copyable.dart';
import '../models/order.dart';
import '../validation_mixin.dart';

class CreateOrderState implements Copyable<CreateOrderState> {
  bool isLoading;
  bool isSuccess;
  String errorMessage;
  int initialPage;
  int activePage;
  String deliveryType;
  String paymentType;
  int novaPostNumber;
  List<Product> products;
  Client client;

  // field errors
  FieldErrors errors;

  CreateOrderState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.initialPage,
    required this.activePage,
    required this.errors,
    required this.deliveryType,
    required this.paymentType,
    required this.novaPostNumber,
    required this.products,
    required this.client,
  });

  static CreateOrderState defaultCreateProductState() {
    return CreateOrderState(
        isLoading: false,
        isSuccess: false,
        errorMessage: '',
        initialPage: 0,
        activePage: 0,
        errors: FieldErrors(),
        deliveryType: '',
        paymentType: '',
        novaPostNumber: 0,
        products: [Product.defaultProduct()],
        client:Client.defaultClient());
  }

  @override
  CreateOrderState copyWith(
      {
      bool? isLoading,
      bool? isEdit,
      bool? isSuccess,
      String? errorMessage,
      int? initialPage,
      int? activePage,
      List<String>? images,
      String? editProductId,
      FieldErrors? errors,
      String? deliveryType,
      String? paymentType,
      int? novaPostNumber,
      List<Product>? products,
      Client? client
      }) {
    return CreateOrderState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      initialPage: initialPage ?? this.initialPage,
      activePage: activePage ?? this.activePage,
      errors: errors ?? this.errors,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      novaPostNumber: novaPostNumber ?? this.novaPostNumber,
      products: products ?? this.products,
      client: client ?? this.client,
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
    buffer.write('.');
    return buffer.toString();
  }
}
