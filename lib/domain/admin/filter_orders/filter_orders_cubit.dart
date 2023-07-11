import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constant/order_constants.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../services/get_it.dart';
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
            status: [],
            createdAt: '',
            updatedAt: '',
            selectedDate:
                DateTimeRange(start: DateTime.now(), end: DateTime.now()))) {
    loadFilterParams();
    dateController = TextEditingController(text: state.createdAt);
  }

  void loadFilterParams() {
    final filterParams = orderRepository.getFilterParams();
    emit(state.copyWith(
        deliveryType: filterParams.deliveryType,
        paymentType: filterParams.paymentType,
        status: filterParams.status,
        selectedDate: filterParams.selectedDate
        ));
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
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      emit(state.copyWith(selectedDate: result));
      String firstDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(result.start.toString()));
      String lastDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(result.end.toString()));
      dateController.text = '$firstDate - $lastDate';
    }
  }

  void resetFilter() {
    emit(FilterOrdersState.defaultFilterOrdersState());
    dateController.text = '';
  }

  void changeStatus(updateStatus) {
    List<String> updatedStatus = state.status;
    if (!state.status.contains(updateStatus)) {
      updatedStatus.add(updateStatus);
      emit(state.copyWith(status: updatedStatus));
    } else {
      updatedStatus.remove(updateStatus);
      emit(state.copyWith(status: updatedStatus));
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
