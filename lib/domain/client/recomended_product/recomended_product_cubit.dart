import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/client/recomended_product/recomended_products_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class RecomendedProductCubit extends Cubit<RecomendedProductState> {
  RecomendedProductCubit()
      : super(RecomendedProductState.defaultRecomendedProductState()) {
    fetchRecomendedProducts();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();


  void moveToPreviustPage() {
    emit(state.copyWith(
        activePage: (state.activePage - 1)
            .clamp(0, state.recomendedProducts.length - 3)));

  }

  void moveToNextPage() {
    emit(state.copyWith(
        activePage: (state.activePage + 1)
            .clamp(0, state.recomendedProducts.length - 3)));
  }

  void fetchRecomendedProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getRecomendedProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        emit(state.copyWith(
            recomendedProducts: allProductsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
