import '../../constant/order_constants.dart';
import '../copyable.dart';
import '../models/city.dart';
import '../models/order.dart';
import '../models/warehouse.dart';
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
  City selectedCity;
  Warehouse selectedWarehouse;
  String status;
  Client client;
  String prepayment;

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
    required this.selectedWarehouse,
    required this.client,
    required this.status,
    required this.prepayment,
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
        selectedCity: City.defaultCity(),
        selectedWarehouse:Warehouse.defaultWarehouse(),
        client: Client.defaultClient(),
        status: 'New',
        prepayment:'150');
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
      Warehouse? selectedWarehouse,
      Client? client,
      String? status,
      String? prepayment
      }) {
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
      selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
      client: client ?? this.client,
      status: status ?? this.status,
      prepayment: prepayment ?? this.prepayment,
    );
  }
}

class FieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? selectedProduct;
  FieldError? selectedPrepayment;

  FieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.selectedProduct,
    this.selectedPrepayment,
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
    buffer.write('.');
    return buffer.toString();
  }
}
