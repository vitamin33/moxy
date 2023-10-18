import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/client/product_details/product_details_effect.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class ProductDetailsCubit
    extends CubitWithEffects<ProductDetailsState, UiEffect> {
  final String? productId;
  ProductDetailsCubit({required this.productId})
      : super(ProductDetailsState.defaultProductDetailsState()) {
    getProductsDetails(productId);
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();

  void getProductsDetails(String? productId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getProductById(productId);
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

  void setSeletedColor(ProductColor color) {
    final updatedDimensions = state.product.dimensions.map((dimension) {
      if (dimension.color.hexCode == color.hexCode) {
        return dimension.copyWith(isSelected: !dimension.isSelected);
      } else {
        return dimension.copyWith(isSelected: false);
      }
    }).toList();
    emit(state.copyWith(
        product: state.product.copyWith(dimensions: updatedDimensions)));
  }
}
