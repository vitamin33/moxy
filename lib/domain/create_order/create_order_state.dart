import '../../constant/order_constants.dart';
import '../copyable.dart';
import '../models/city.dart';
import '../models/order.dart';
import '../validation_mixin.dart';

class CreateOrderState implements Copyable<CreateOrderState> {
  bool isLoading;
  bool isEdit;
  bool isSuccess;
  String errorMessage;
  int initialPage;
  int activePage;
  DeliveryType deliveryType;
  PaymentType paymentType;
  int novaPostNumber;
  int productListPrice;
  List<OrderedItem> selectedProducts;
  City? selectedCity;
  String status;
  Client client;

  // field errors
  FieldErrors errors;

  CreateOrderState({
    required this.isLoading,
    required this.isEdit,
    required this.isSuccess,
    required this.errorMessage,
    required this.initialPage,
    required this.activePage,
    required this.errors,
    required this.deliveryType,
    required this.paymentType,
    required this.novaPostNumber,
    required this.productListPrice,
    required this.selectedProducts,
    required this.selectedCity,
    required this.client,
    required this.status,
  });

  static CreateOrderState defaultCreateProductState() {
    return CreateOrderState(
        isLoading: false,
        isEdit: false,
        isSuccess: false,
        errorMessage: '',
        initialPage: 0,
        activePage: 0,
        errors: FieldErrors(),
        deliveryType: DeliveryType.novaPost,
        paymentType: PaymentType.fullPayment,
        novaPostNumber: 0,
        productListPrice: 0,
        selectedProducts: [],
        selectedCity: null,
        client: Client.defaultClient(),
        status: '');
  }

  @override
  CreateOrderState copyWith(
      {bool? isLoading,
      bool? isEdit,
      bool? isSuccess,
      String? errorMessage,
      int? initialPage,
      int? activePage,
      List<String>? images,
      String? editProductId,
      FieldErrors? errors,
      DeliveryType? deliveryType,
      PaymentType? paymentType,
      int? novaPostNumber,
      int? productListPrice,
      List<OrderedItem>? selectedProducts,
      City? selectedCity,
      Client? client,
      String? status}) {
    return CreateOrderState(
      isLoading: isLoading ?? this.isLoading,
      isEdit: isEdit ?? this.isEdit,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      initialPage: initialPage ?? this.initialPage,
      activePage: activePage ?? this.activePage,
      errors: errors ?? this.errors,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      novaPostNumber: novaPostNumber ?? this.novaPostNumber,
      productListPrice: productListPrice ?? this.productListPrice,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedCity: selectedCity ?? this.selectedCity,
      client: client ?? this.client,
      status: status ?? this.status,
    );
  }
}

class FieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;

  FieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
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
    buffer.write('.');
    return buffer.toString();
  }
}
