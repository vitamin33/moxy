import 'package:moxy/domain/edit_order/edit_order_state.dart';
import 'package:moxy/domain/ui_effect.dart';

import '../../constant/order_constants.dart';
import '../../data/repositories/order_repository.dart';
import '../../services/cubit_with_effects.dart';
import '../../services/get_it.dart';
import '../../utils/common.dart';
import '../mappers/order_mapper.dart';
import '../models/city.dart';
import '../models/order.dart';
import '../models/warehouse.dart';
import '../validation_mixin.dart';

class EditOrderCubit extends CubitWithEffects<EditOrderState, UiEffect>
    with ValidationMixin {
 final orderMapper = locate<OrderMapper>();
  final orderRepository = locate<OrderRepository>();

  EditOrderCubit()
      : super(EditOrderState(
            isLoading: false,
            isSuccess: false,
            isEditName: false,
            isEditPhone: false,
            errorMessage: '',
            errors: FieldErrors(),
            deliveryType: DeliveryType.novaPost,
            paymentType: PaymentType.fullPayment,
            selectedProducts: [],
            selectedCity: City.defaultCity(),
            selectedWarehouse: Warehouse.defaultWarehouse(),
            client: Client.defaultClient(),
            status: 'New',
            prepayment: '150'));


  void editOrder() async {
    try {
      emit(state.copyWith(isLoading: true));
      final order = orderMapper.mapToNetworkCreateOrder(
          state.deliveryType,
          state.paymentType,
          state.selectedProducts,
          state.selectedWarehouse,
          state.client,
          state.selectedCity,
          state.status,
          state.prepayment);
      final pushOrder = await orderRepository.addOrder(order);
      pushOrder.when((success) {
        emit(state.copyWith(isLoading: false));
        emit(state.copyWith(isSuccess: true, isLoading: false));
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false,));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  void getOrder(Order order) {
    emit(state.copyWith(
      deliveryType: order.deliveryType,
      paymentType: order.paymentType,
      status: order.status,
      client: order.client,
      selectedProducts: order.orderedItems,
    ));
  }

  void changeStatus(updateStatus) {
    emit(state.copyWith(status: updateStatus));
  }

  void changePayment(updatePayment) {
    emit(state.copyWith(paymentType: updatePayment));
  }

  void changeDelivery(updateDelivery) {
    emit(state.copyWith(deliveryType: updateDelivery));
  }

  void changeEditName() {
    emit(state.copyWith(isEditName: !state.isEditName));
  }
  void changeEditPhone() {
    emit(state.copyWith(isEditPhone: !state.isEditPhone));
  }
  // void editName() {
  //   emit(state.copyWith(deliveryType: updateDelivery));
  // }
}
