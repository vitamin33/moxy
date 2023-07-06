import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../constant/order_constants.dart';
import 'filter_orders_state.dart';

class FilterOrdersCubit extends Cubit<FilterOrdersState> {
  late TextEditingController dateController;
  FilterOrdersCubit()
      : super(FilterOrdersState(
            isLoading: false,
            deliveryType: FilterDeliveryType.empty,
            paymentType: FilterPaymentType.empty,
            status: '',
            createdAt: '',
            updatedAt: '',
            selectedDate: DateTime.now())) {
    dateController = TextEditingController(text: state.createdAt);
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
