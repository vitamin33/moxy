import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../constant/order_constants.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../services/get_it.dart';
import '../../models/order.dart';
import '../all_orders/all_orders_cubit.dart';
import 'filter_orders_state.dart';

class FilterOrdersCubit extends Cubit<FilterOrdersState> {
  final orderRepository = locate<OrderRepository>();
  late TextEditingController dateController;
  late AllOrdersCubit allOrdersCubit;

  FilterOrdersCubit()
      : super(FilterOrdersState(
            isLoading: false,
            deliveryType: FilterDeliveryType.empty,
            paymentType: FilterPaymentType.empty,
            status: '',
            createdAt: '',
            updatedAt: '',
            selectedDate: DateTime.now())) {
    loadFilterParams();
    dateController = TextEditingController(text: state.createdAt);
  }

  void loadFilterParams() {
    final filterParams = orderRepository.getFilterParams();
    emit(state.copyWith(
        deliveryType: filterParams.deliveryType,
        paymentType: filterParams.paymentType,
        status: filterParams.status));
  }

  void saveFilterParams() {
    final filterParams = FilterOrdersState(
        deliveryType: state.deliveryType,
        paymentType: state.paymentType,
        status: state.status,
        createdAt: '',
        isLoading: false,
        selectedDate: state.selectedDate,
        updatedAt: state.updatedAt);
    orderRepository.saveFilterParams(filterParams);
  }

  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != state.selectedDate) {
      state.selectedDate = picked;
      dateController.text = state.selectedDate.toString();
    }
  }

  void resetFilter() {
    emit(FilterOrdersState.defaultFilterOrdersState());
  }

  void changeStatus(updateStatus) {
    if (updateStatus != state.status) {
      emit(state.copyWith(status: updateStatus));
    } else {
      emit(state.copyWith(status: ''));
    }
  }

  void changePayment(updatePayment) {
    if (updatePayment != state.paymentType) {
      emit(state.copyWith(paymentType: updatePayment));
    } else {
      emit(state.copyWith(paymentType: FilterPaymentType.empty));
    }
  }

  void changeDelivery(updateDelivery) {
    if (updateDelivery != state.deliveryType) {
      emit(state.copyWith(deliveryType: updateDelivery));
    } else {
      emit(state.copyWith(deliveryType: FilterDeliveryType.empty));
    }
  }
}
