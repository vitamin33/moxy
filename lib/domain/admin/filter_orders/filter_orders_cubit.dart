import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/domain/mappers/filter_params_mapper.dart';
import 'package:moxy/domain/models/filter_order_param.dart';
import '../../../constant/order_constants.dart';
import '../../../services/get_it.dart';
import '../all_orders/all_orders_cubit.dart';
import 'filter_orders_state.dart';

class FilterOrdersCubit extends Cubit<FilterOrdersState> {
  final filterRepository = locate<FilterRepository>();
  final filterMapper = locate<FilterParamsMapper>();
  late TextEditingController dateController;
  late AllOrdersCubit allOrdersCubit;

  FilterOrdersCubit() : super(FilterOrdersState.defaultFilterOrdersState()) {
    loadFilterParams();
    dateController = TextEditingController(text: state.createdAt);
  }

  Future<FilterOrderParams> loadFilterParams() async {
    final filterParams = filterRepository.getFilterParams();
    emit(state.copyWith(
      deliveryType: filterParams.deliveryType,
      paymentType: filterParams.paymentType,
      status: filterParams.status,
    ));
    return filterParams;
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
    filterRepository
        .notifyFilterParams(filterMapper.mapToFilterParams(filterParams));
  }

  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.selectedDate?.start ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != state.selectedDate) {
      // TODO here we need to setup right both dates: start and end dates
      state.selectedDate = DateTimeRange(start: picked, end: picked);
      dateController.text = state.selectedDate.toString();
    }
  }

  void resetFilter() {
    emit(FilterOrdersState.defaultFilterOrdersState());
    filterRepository.resetFilterParams();
  }

  void changeStatus(String updateStatus) {
    if (updateStatus != state.status) {
      filterRepository.saveStatusFilterParam(updateStatus);
      emit(state.copyWith(status: updateStatus));
    } else {
      emit(state.copyWith(status: ''));
    }
  }

  void changePayment(FilterPaymentType updatePayment) {
    if (updatePayment != state.paymentType) {
      filterRepository.savePaymentFilterParam(updatePayment);
      emit(state.copyWith(paymentType: updatePayment));
    } else {
      emit(state.copyWith(paymentType: FilterPaymentType.empty));
    }
  }

  void changeDelivery(FilterDeliveryType updateDelivery) {
    if (updateDelivery != state.deliveryType) {
      filterRepository.saveDeliveryFilterParam(updateDelivery);
      emit(state.copyWith(deliveryType: updateDelivery));
    } else {
      emit(state.copyWith(deliveryType: FilterDeliveryType.empty));
    }
  }

  void changeDateRange(DateTimeRange range) {
    // TODO check this implementation
    if (range != state.selectedDate) {
      filterRepository.saveDateRangeFilterParam(range);
      emit(state.copyWith(selectedDate: range));
    } else {
      emit(state.copyWith(selectedDate: null));
    }
  }
}
