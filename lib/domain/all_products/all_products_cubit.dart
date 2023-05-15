import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final produtctMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();

  AllProductsCubit()
      : super(AllProductsState(
            allProducts: [], isLoading: false, errorMessage: '')) {
    allProducts();
  }

  void allProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getAllProducts();
      result.when((success) {
        final products = produtctMapper.mapToProductList(success);
        emit(state.copyWith(allProducts: products));
        emit(state.copyWith(isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
