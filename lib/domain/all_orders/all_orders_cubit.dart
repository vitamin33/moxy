import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import 'all_orders_state.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  AllOrdersCubit() : super(const AllOrdersState.initial()) {
    allProducts();
  }

  final productRepository = locate<OrderRepository>();

  void allProducts() async {
    try {
      emit(const AllOrdersState.loading());
      final result = await productRepository.getAllOrders();
      result.when((success) {
        emit(AllOrdersState.initial(allOrders: success));
      }, (error) {
        emit(const AllOrdersState.error('Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}