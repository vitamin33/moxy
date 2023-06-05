import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/order_repository.dart';
import 'package:moxy/domain/all_orders/all_orders_state.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';
import '../mappers/order_mapper.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  final orderMapper = locate<OrderMapper>();
  final orderRepository = locate<OrderRepository>();

  AllOrdersCubit()
      : super(
            AllOrdersState(allOrders: [], isLoading: false, errorMessage: '')) {
    allOrders();
  }

  void allOrders() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await orderRepository.getAllOrders();
      result.when((success) {
        final orders = orderMapper.mapToOrderList(success);
        emit(state.copyWith(allUsers: orders));
        emit(state.copyWith(isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
