import 'package:moxy/domain/all_products/all_products_effects.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import '../ui_effect.dart';
import 'all_products_state.dart';

class AllProductsCubit extends CubitWithEffects<AllProductsState, UiEffect> {
  final produtctMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();

  AllProductsCubit() : super(AllProductsState.defaultAllProductsState()) {
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
        emitEffect(ProductsLoadingFailed(error.toString()));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
