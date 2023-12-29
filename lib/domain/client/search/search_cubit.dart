import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/client/search/search_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class SearchCubit extends CubitWithEffects<SearchState, UiEffect>
    with ValidationMixin {
  late List<Product> originalProductList;
  SearchCubit() : super(SearchState.defaultSearchState()) {
    fetchAllProducts();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();

  void fetchAllProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getSearchProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        originalProductList = allProductsList;
        emit(state.copyWith(searchProduct: allProductsList, isLoading: false));
      }, (error) {
        moxyPrint('$error');
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void searchProduct(String value) {
    final searchProduct = originalProductList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.description.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(state.copyWith(searchProduct: searchProduct));
  }
}
