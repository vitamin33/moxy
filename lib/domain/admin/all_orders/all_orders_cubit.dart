import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/order_repository.dart';
import 'package:moxy/domain/admin/all_orders/all_orders_state.dart';
import 'package:moxy/utils/common.dart';

import '../../../services/get_it.dart';
import '../../mappers/order_mapper.dart';


class AllOrdersCubit extends Cubit<AllOrdersState> {
  final orderRepository = locate<OrderRepository>();
  final orderMapper = locate<OrderMapper>();

  late final StreamSubscription _filterOrderSubscription;

  AllOrdersCubit()
      : super(
            AllOrdersState(allOrders: [], isLoading: false, errorMessage: '')) {
    allOrders();
    _subscribe();
  }

  void _subscribe() {
    _filterOrderSubscription =
        orderRepository.filterParamsStream.listen((filterState) {
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
      final result = await orderRepository.getAllOrders();
      result.when((success) {
        emit(state.copyWith(allOrders: success, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
