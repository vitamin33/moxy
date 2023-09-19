import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/domain/validation_mixin.dart';

class CheckoutState implements Copyable<CheckoutState> {
  final bool isLoading;
  final String? basketProductsError;
  final Basket basket;
  DeliveryType deliveryType;
  PaymentType paymentType;
  City selectedCity;
  Warehouse selectedWarehouse;
  Client client;
  bool isFreeShipping;
  FieldErrors errors;

  CheckoutState({
    required this.isLoading,
    required this.basketProductsError,
    required this.basket,
    required this.deliveryType,
    required this.paymentType,
    required this.selectedCity,
    required this.selectedWarehouse,
    required this.client,
    required this.isFreeShipping,
    required this.errors,
  });

  static defaultState() {
    return CheckoutState(
      isLoading: false,
      basket: Basket.defaultBasket(),
      deliveryType: DeliveryType.novaPost,
      paymentType: PaymentType.fullPayment,
      selectedCity: City.defaultCity(),
      selectedWarehouse: Warehouse.defaultWarehouse(),
      client: Client.defaultClient(),
      basketProductsError: null,
      isFreeShipping: false,
      errors: FieldErrors.noErrors(),
    );
  }

  @override
  CheckoutState copyWith({
    bool? isLoading,
    String? basketProductsError,
    Basket? basket,
    DeliveryType? deliveryType,
    PaymentType? paymentType,
    City? selectedCity,
    Warehouse? selectedWarehouse,
    Client? client,
    bool? isFreeShipping,
    FieldErrors? errors,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      basketProductsError: basketProductsError ?? this.basketProductsError,
      basket: basket ?? this.basket,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
      client: client ?? this.client,
      isFreeShipping: isFreeShipping ?? this.isFreeShipping,
      errors: errors ?? this.errors,
    );
  }
}

class FieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? selectedCity;
  FieldError? selectedWarehouse;

  FieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.selectedCity,
    this.selectedWarehouse,
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
    if (selectedCity != null) {
      buffer.write('selectedCity ');
    }
    if (selectedWarehouse != null) {
      buffer.write('selectedWarehouse ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
