import '../../../constant/order_constants.dart';
import '../../copyable.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/warehouse.dart';
import '../../validation_mixin.dart';

class EditOrderState implements Copyable<EditOrderState> {
  bool isLoading;
  bool isSuccess;
  bool isEditName;
  bool isEditPhone;
  String errorMessage;
  String orderId;
  DeliveryType deliveryType;
  PaymentType paymentType;
  List<OrderedItem> selectedProducts;
  City selectedCity;
  Warehouse selectedWarehouse;
  String status;
  Client client;
  int prepayment;
  String createdAt;
  String updatedAt;

  // field errors
  FieldErrors errors;

  EditOrderState({
    required this.isLoading,
    required this.isSuccess,
    required this.isEditName,
    required this.isEditPhone,
    required this.errorMessage,
    required this.errors,
    required this.orderId,
    required this.deliveryType,
    required this.paymentType,
    required this.selectedProducts,
    required this.selectedCity,
    required this.selectedWarehouse,
    required this.client,
    required this.status,
    required this.prepayment,
    required this.createdAt,
    required this.updatedAt,
  });

  static EditOrderState defaultEditOrderState() {
    return EditOrderState(
        isLoading: false,
        isSuccess: false,
        isEditName: false,
        isEditPhone: false,
        errorMessage: '',
        errors: FieldErrors(),
        orderId: '',
        deliveryType: DeliveryType.novaPost,
        paymentType: PaymentType.fullPayment,
        selectedProducts: [OrderedItem.defaultOrderedItem()],
        selectedCity: City.defaultCity(),
        selectedWarehouse: Warehouse.defaultWarehouse(),
        client: Client.defaultClient(),
        status: 'New',
        prepayment: 150,
        createdAt: '',
        updatedAt: '');
  }

  @override
  EditOrderState copyWith(
      {bool? isLoading,
      bool? isSuccess,
      bool? isEditName,
      bool? isEditPhone,
      String? errorMessage,
      FieldErrors? errors,
      String? orderId,
      DeliveryType? deliveryType,
      PaymentType? paymentType,
      List<OrderedItem>? selectedProducts,
      City? selectedCity,
      Warehouse? selectedWarehouse,
      Client? client,
      String? status,
      int? prepayment,
      String? createdAt,
      String? updatedAt}) {
    return EditOrderState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEditName: isEditName ?? this.isEditName,
      isEditPhone: isEditPhone ?? this.isEditPhone,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
      orderId: orderId ?? this.orderId,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
      client: client ?? this.client,
      status: status ?? this.status,
      prepayment: prepayment ?? this.prepayment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
