import '../../../constant/order_constants.dart';
import '../../copyable.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/warehouse.dart';

class FilterOrdersState implements Copyable<FilterOrdersState> {
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

  FilterOrdersState({
    required this.isLoading,
    required this.isSuccess,
    required this.isEditName,
    required this.isEditPhone,
    required this.errorMessage,
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

  static FilterOrdersState defaultEditOrderState() {
    return FilterOrdersState(
        isLoading: false,
        isSuccess: false,
        isEditName: false,
        isEditPhone: false,
        errorMessage: '',
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
  FilterOrdersState copyWith(
      {bool? isLoading,
      bool? isSuccess,
      bool? isEditName,
      bool? isEditPhone,
      String? errorMessage,
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
    return FilterOrdersState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEditName: isEditName ?? this.isEditName,
      isEditPhone: isEditPhone ?? this.isEditPhone,
      errorMessage: errorMessage ?? this.errorMessage,
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

