import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(const AllProductsState.initial()) {
    allProducts();
  }

  final productRepository = locate<ProductRepository>();

  void allProducts() async {
    try {
      emit(const AllProductsState.loading());
      final result = await productRepository.getAllProducts();
      result.when((success) {
        emit(AllProductsState.initial(allProducts: success));
      }, (error) {
        emit(const AllProductsState.error('Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
