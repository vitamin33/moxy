import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_state.dart';
import 'package:moxy/domain/ui_effect.dart';

import '../../../constant/order_constants.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../services/cubit_with_effects.dart';
import '../../../services/get_it.dart';
import '../../../utils/common.dart';
import '../../mappers/order_mapper.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/warehouse.dart';
import '../../validation_mixin.dart';

class EditOrderCubit extends CubitWithEffects<EditOrderState, UiEffect>
    with ValidationMixin {
  final orderRepository = locate<OrderRepository>();
  final productRepository = locate<ProductRepository>();
  final orderMapper = locate<OrderMapper>();
  late TextEditingController paymentController;
  late TextEditingController dateController;

  EditOrderCubit()
      : super(EditOrderState(
            isLoading: false,
            isSuccess: false,
            isEditName: false,
            isEditPhone: false,
            errorMessage: '',
            errors: FieldErrors(),
            orderId: '',
            deliveryType: DeliveryType.novaPost,
            paymentType: PaymentType.fullPayment,
            selectedProducts: [],
            selectedCity: City.defaultCity(),
            selectedWarehouse: Warehouse.defaultWarehouse(),
            client: Client.defaultClient(),
            status: 'New',
            prepayment: 150,
            createdAt: '',
            updatedAt: '')) {
    paymentController =
        TextEditingController(text: state.prepayment.toString());
    dateController = TextEditingController(text: state.createdAt);
  }

  final TextEditingController nameEditController = TextEditingController();
  final TextEditingController phoneEditController = TextEditingController();

  void editOrder() async {
    try {
      emit(state.copyWith(isLoading: true));
      final order = orderMapper.mapToNetworkEditOrder(
          state.orderId,
          state.deliveryType,
          state.paymentType,
          state.selectedProducts,
          state.selectedWarehouse,
          state.client,
          state.selectedCity,
          state.status,
          state.prepayment.toString());
      final pushOrder = await orderRepository.editOrder(order);
      pushOrder.when((success) {
        emit(state.copyWith(isLoading: false));
        emit(state.copyWith(isSuccess: true, isLoading: false));
      }, (error) {
        emit(state.copyWith(
          errorMessage: 'Failed',
          isLoading: false,
        ));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  void getOrder(Order order) {
    emit(state.copyWith(
      selectedWarehouse: Warehouse(
          ref: order.novaPost.ref,
          postMachineType: order.novaPost.postMachineType!,
          description: order.novaPost.presentName,
          number: order.novaPost.number),
      orderId: order.id,
      prepayment: order.cashAdvanceValue,
      selectedCity: order.city,
      deliveryType: order.deliveryType,
      paymentType: order.paymentType,
      status: order.status,
      client: Client(
          id: order.client.id,
          city: order.client.city,
          firstName: order.client.firstName,
          mobileNumber: order.client.mobileNumber,
          secondName: order.client.secondName),
      selectedProducts: order.orderedItems,
      createdAt: formattedDateTime(order.createdAt),
      updatedAt: order.updatedAt,
    ));
  }

  String formattedDateTime(date) {
    DateTime inputDateTime = DateTime.parse(date);
    String formattedDateTime =
        DateFormat('dd.MM.yy HH:mm').format(inputDateTime);
    return formattedDateTime;
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
    nameEditController.value = TextEditingValue(
        text: '${state.client.firstName} ${state.client.secondName}');
    emit(state.copyWith(isEditName: true));
  }

  void changeEditPhone() {
    phoneEditController.value =
        TextEditingValue(text: state.client.mobileNumber);
    emit(state.copyWith(isEditPhone: true));
  }

  void addEditPhone() {
    final phoneTextField = phoneEditController.text;
    emit(state.copyWith(
        isEditPhone: false,
        client: state.client.copyWith(mobileNumber: phoneTextField)));
  }

  void addEditName() {
    final textFieldValue = nameEditController.text;
    final arrTextField = textFieldValue.split(' ');
    emit(state.copyWith(
        isEditName: false,
        client: state.client.copyWith(
            firstName: arrTextField[0], secondName: arrTextField[1])));
  }

  void selectCity(City? city) {
    emit(state.copyWith(
        selectedCity: city, selectedWarehouse: Warehouse.defaultWarehouse()));
  }

  void selectWarehouse(Warehouse? warehouse) {
    emit(state.copyWith(selectedWarehouse: warehouse));
  }

  void clearState() {
    emit(EditOrderState.defaultEditOrderState());
  }

  void editSelectedProduct() {
    productRepository.addToSelectedProductStream(state.selectedProducts);
  }
}
