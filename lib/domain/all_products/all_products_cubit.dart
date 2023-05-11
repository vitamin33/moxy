import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final produtctMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();

  AllProductsCubit() : super(const AllProductsState.initial()) {
    allProducts();
  }

  void allProducts() async {
    try {
      emit(const AllProductsState.loading());
      final result = await productRepository.getAllProducts();
      result.when((success) {
        final products = produtctMapper.mapToProductList(success);
        emit(AllProductsState.initial(allProducts: products));
      }, (error) {
        emit(const AllProductsState.error('Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
