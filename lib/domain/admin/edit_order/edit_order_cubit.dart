import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
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
  final _productMapper = locate<ProductMapper>();

  final TextEditingController nameEditController = TextEditingController();
  final TextEditingController phoneEditController = TextEditingController();
  late final StreamSubscription _selectedProductSubscription;
  late TextEditingController paymentController;
  late TextEditingController ukrPostInfoController;

  EditOrderCubit() : super(EditOrderState.defaultEditOrderState()) {
    _subscribe();
  }

  void _subscribe() {
    _selectedProductSubscription = productRepository.selectedProducts.listen(
      (items) {
        final productDimensList =
            _productMapper.mapToProductDimensionList(items);
        emit(state.copyWith(selectedProducts: productDimensList));
      },
      onError: (error) =>
          {moxyPrint('Error during selected products listening.')},
    );
  }

  @override
  Future<void> close() {
    _selectedProductSubscription.cancel();
    moxyPrint('Cubit closed');
    return super.close();
  }

  void editOrder() async {
    try {
      emit(state.copyWith(isLoading: true));
      List<OrderedItem> selectedProducts =
          productRepository.currentSelectedProducts ?? [];
      final order = orderMapper.mapToNetworkEditOrder(
        state.orderId,
        state.deliveryType,
        state.paymentType,
        selectedProducts,
        state.selectedWarehouse,
        state.client,
        state.selectedCity,
        state.status,
        state.prepayment.toString(),
        state.ukrPostInfo,
      );
      final pushOrder = await orderRepository.editOrder(order);
      pushOrder.when((success) {
        emit(state.copyWith(isSuccess: true, isLoading: false));
      }, (error) {
        emit(state.copyWith(
          errorMessage: 'Failed',
          isLoading: false,
          isSuccess: false,
        ));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  void getOrder(Order order) {
    emitOrder(order);
    paymentController =
        TextEditingController(text: state.prepayment.toString());
    ukrPostInfoController = TextEditingController(text: state.ukrPostInfo);

    requestOrderFromNetwork(order.id);
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
    if (updatePayment == PaymentType.fullPayment) {
      emit(state.copyWith(cashAdvanceValue: 0));
    }
  }

  void cashAdvancePrepayment(value) {
    if (value != '') {
      final updatePrepayment = int.parse(value);
      emit(state.copyWith(cashAdvanceValue: updatePrepayment));
    }
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

  void ukrPostInfoChanged(value) {
    if (value != '') {
      emit(state.copyWith(ukrPostInfo: value));
    }
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
    paymentController.clear();
  }

  void editSelectedProduct() {
    productRepository.addToSelectedProductStream(state.orderedItems);
  }

  void requestOrderFromNetwork(String? id) async {
    if (id != null) {
      final result = await orderRepository.getOrderById(id);
      result.when((success) {
        emitOrder(success);
      }, (error) {
        emit(state.copyWith(
          errorMessage: 'Failed to load order details',
          isLoading: false,
          isSuccess: false,
        ));
      });
    }
  }

  void emitOrder(Order order) {
    emit(state.copyWith(
      isLoading: false,
      selectedWarehouse: order.novaPost,
      orderId: order.id,
      cashAdvanceValue: order.cashAdvanceValue,
      selectedCity: order.city,
      deliveryType: order.deliveryType,
      paymentType: order.paymentType,
      status: order.status.statusTitle,
      client: Client(
          id: order.client.id,
          city: order.client.city,
          firstName: order.client.firstName,
          mobileNumber: order.client.mobileNumber,
          secondName: order.client.secondName),
      selectedProducts:
          _productMapper.mapToProductDimensionList(order.orderedItems),
      orderedItems: order.orderedItems,
      createdAt: formattedDateTime(order.createdAt),
      updatedAt: order.updatedAt,
      ukrPostInfo: order.ukrPostInfo,
    ));
  }
}
