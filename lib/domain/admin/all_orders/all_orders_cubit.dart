import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/data/repositories/order_repository.dart';
import 'package:moxy/domain/admin/all_orders/all_orders_state.dart';
import 'package:moxy/utils/common.dart';

import '../../../services/get_it.dart';
import '../../mappers/order_mapper.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  final filterRepository = locate<FilterRepository>();
  final ordersRepository = locate<OrderRepository>();
  final orderMapper = locate<OrderMapper>();

  late final StreamSubscription _filterOrderSubscription;

  AllOrdersCubit() : super(AllOrdersState.defaultAllProductsState()) {
    allOrders();
    _subscribe();
  }

  void _subscribe() {
    _filterOrderSubscription =
        filterRepository.filterParamsStream.listen((filterState) {
      allOrders();
    });
  }

  @override
  Future<void> close() {
    _filterOrderSubscription.cancel();
    return super.close();
  }

  void allOrders() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await ordersRepository.getAllOrders();
      checkFilters();
      result.when((success) {
        emit(state.copyWith(allOrders: success, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  checkFilters() {
    final filters = filterRepository.getFilterParams();
    emit(state.copyWith(
      paymentFilter: filters.paymentType,
      deliveryFilter: filters.deliveryType,
      statusFilter: filters.status,
      dateRangeFilter: filters.dateRange,
    ));
  }

  void clearDeliveryTypeFilter() async {
    filterRepository.clearDeliveryTypeFilter();
    emit(state.copyWith(deliveryFilter: FilterDeliveryType.empty));
  }

  void clearPaymentTypeFilter() {
    filterRepository.clearPaymentTypeFilter();
    emit(state.copyWith(paymentFilter: FilterPaymentType.empty));
  }

  void clearStatusFilter() {
    filterRepository.clearStatusFilter();
    emit(state.copyWith(statusFilter: ''));
  }

  void clearDateRangeFilter() {
    filterRepository.clearDateRangeFilter();
    emit(state.copyWith(dateRangeFilter: null));
  }

  Future<void> refreshOrderList() async {
    allOrders();
  }
}
