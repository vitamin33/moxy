// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/services/get_it.dart';

import '../../../utils/common.dart';
import 'new_product_list_state.dart';

class NewProductListCubit extends Cubit<NewProductListState> {
  NewProductListCubit()
      : super(NewProductListState.defaultNewProductListState()) {
    allSellingProduct();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();

  void allSellingProduct() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getAllSellingProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        emit(state.copyWith(
            allSellingProduct: allProductsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
