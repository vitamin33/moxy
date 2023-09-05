import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/warehouse.dart';

class CheckoutState implements Copyable<CheckoutState> {
  final bool isLoading;
  final String? basketProductsError;
  final Basket basket;
  DeliveryType deliveryType;
  PaymentType paymentType;
  City selectedCity;
  Warehouse selectedWarehouse;
  Client client;

  CheckoutState({
    required this.isLoading,
    required this.basketProductsError,
    required this.basket,
    required this.deliveryType,
    required this.paymentType,
    required this.selectedCity,
    required this.selectedWarehouse,
    required this.client,
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
    );
  }
}
