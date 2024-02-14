import 'package:moxy/constant/order_status.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/dimension_product.dart';

import '../../../constant/order_constants.dart';
import '../../copyable.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/status.dart';
import '../../models/warehouse.dart';
import '../../validation_mixin.dart';

class CreateOrderState implements Copyable<CreateOrderState> {
  bool isLoading;
  bool isEdit;
  bool isSuccess;
  int initialPage;
  int activePage;
  DeliveryType deliveryType;
  PaymentType paymentType;
  int novaPostNumber;
  int productListPrice;
  List<DimensionProduct> selectedProducts;
  City? selectedCity;
  Warehouse? selectedWarehouse;
  Status status;
  Client client;
  int cashAdvanceValue;
  List<OrderStatus> availableStatuses = [];
  String? ukrPostInfo;
  String? novaEN;

  // field errors
  FieldErrors errors;

  CreateOrderState({
    required this.isLoading,
    required this.isEdit,
    required this.isSuccess,
    required this.initialPage,
    required this.activePage,
    required this.errors,
    required this.deliveryType,
    required this.paymentType,
    required this.novaPostNumber,
    required this.productListPrice,
    required this.selectedProducts,
    required this.selectedCity,
    required this.selectedWarehouse,
    required this.client,
    required this.status,
    required this.cashAdvanceValue,
    required this.availableStatuses,
    required this.ukrPostInfo,
    required this.novaEN,
  });

  static CreateOrderState defaultCreateProductState() {
    return CreateOrderState(
      isLoading: false,
      isEdit: false,
      isSuccess: false,
      initialPage: 0,
      activePage: 0,
      errors: FieldErrors(),
      deliveryType: DeliveryType.novaPost,
      paymentType: PaymentType.fullPayment,
      novaPostNumber: 0,
      productListPrice: 0,
      selectedProducts: [],
      selectedCity: null,
      selectedWarehouse: null,
      client: Client.defaultClient(),
      status: Status.defaultStatus(),
      cashAdvanceValue: defaultCashAvanceValue,
      availableStatuses: [],
      ukrPostInfo: null,
      novaEN: null,
    );
  }

  @override
  CreateOrderState copyWith({
    bool? isLoading,
    bool? isEdit,
    bool? isSuccess,
    int? initialPage,
    int? activePage,
    List<String>? chosenImages,
    String? editProductId,
    FieldErrors? errors,
    DeliveryType? deliveryType,
    PaymentType? paymentType,
    int? novaPostNumber,
    int? productListPrice,
    List<DimensionProduct>? selectedProducts,
    City? selectedCity,
    Warehouse? selectedWarehouse,
    Client? client,
    Status? status,
    int? cashAdvanceValue,
    List<OrderStatus>? availableStatuses,
    String? ukrPostInfo,
    String? novaEN,
  }) {
    return CreateOrderState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      isSuccess: isSuccess ?? this.isSuccess,
      initialPage: initialPage ?? this.initialPage,
      activePage: activePage ?? this.activePage,
      errors: errors ?? this.errors,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      novaPostNumber: novaPostNumber ?? this.novaPostNumber,
      productListPrice: productListPrice ?? this.productListPrice,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
      client: client ?? this.client,
      status: status ?? this.status,
      cashAdvanceValue: cashAdvanceValue ?? this.cashAdvanceValue,
      availableStatuses: availableStatuses ?? this.availableStatuses,
      ukrPostInfo: ukrPostInfo ?? this.ukrPostInfo,
      novaEN: novaEN ?? this.novaEN,
    );
  }
}

class FieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? selectedProduct;
  FieldError? selectedPrepayment;
  FieldError? ukrPostInfo;

  FieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.selectedProduct,
    this.selectedPrepayment,
    this.ukrPostInfo,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (firstName != null) {
      buffer.write('firstName ');
    }
    if (secondName != null) {
      buffer.write('secondName ');
    }
    if (phoneNumber != null) {
      buffer.write('phoneNumber ');
    }
    if (selectedProduct != null) {
      buffer.write('selectedProduct ');
    }
    if (selectedPrepayment != null) {
      buffer.write('selectedPrepayment ');
    }
    if (ukrPostInfo != null) {
      buffer.write('ukrPostInfo ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
