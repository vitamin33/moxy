import '../../../constant/order_constants.dart';
import '../../copyable.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/warehouse.dart';

class FilterOrdersState implements Copyable<FilterOrdersState> {
  bool isLoading;
  DeliveryType deliveryType;
  PaymentType paymentType;
  String status;
  String createdAt;
  String updatedAt;

  FilterOrdersState({
    required this.isLoading,
    required this.deliveryType,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  static FilterOrdersState defaultFilterOrdersState() {
    return FilterOrdersState(
        isLoading: false,
        deliveryType: DeliveryType.novaPost,
        paymentType: PaymentType.fullPayment,
        status: 'New',
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
      deliveryType: deliveryType ?? this.deliveryType,
      paymentType: paymentType ?? this.paymentType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
