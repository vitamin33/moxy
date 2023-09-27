import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/client/product_details/product_details_effect.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class ProductDetailsCubit
    extends CubitWithEffects<ProductDetailsState, UiEffect> {
  ProductDetailsCubit()
      : super(ProductDetailsState.defaultProductDetailsState());

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();

  void getProductsDetails(String productId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getProductsDetails(productId);
      result.when((success) {
        final product = productMapper.mapToProduct(success);
        emit(state.copyWith(product: product, isLoading: false));
      }, (error) {
        emitEffect(ProductDetailsApiRequestFailed(
            'Failed get product details ${error.toString()}'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
