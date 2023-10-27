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
        emit(state.copyWith(
          productDetails: state.productDetails.copyWith(product: product),
          isLoading: false,
        ));
      }, (error) {
        emitEffect(ProductDetailsApiRequestFailed(
            'Failed get product details ${error.toString()}'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void setSeletedColor(Dimension selectedDimension) {
    final updatedIsSelectedInProduct =
        state.productDetails.product.dimensions.map((dimension) {
      if (dimension.color.hexCode == selectedDimension.color.hexCode) {
        return dimension.copyWith(isSelected: !dimension.isSelected);
      } else {
        return dimension.copyWith(isSelected: false);
      }
    }).toList();
    final updateSelectedDimension = Dimension(
        color: selectedDimension.color,
        quantity: 1,
        material: selectedDimension.material,
        size: selectedDimension.size,
        images: selectedDimension.images);
    emit(state.copyWith(
        productDetails: state.productDetails.copyWith(
      dimension: updateSelectedDimension,
      product: state.productDetails.product
          .copyWith(dimensions: updatedIsSelectedInProduct),
    )));
  }

  bool checkMaxQuantityAvailability() {
    Dimension orderedDimen = state.productDetails.dimension;
    Dimension productDimen = state.productDetails.product.dimensions
        .firstWhere((d) => d.color.id == orderedDimen.color.id);
    if (orderedDimen.quantity < productDimen.quantity) {
      return true;
    }
    return false;
  }

  bool checkMinQuantityAvailability() {
    Dimension orderedDimen = state.productDetails.dimension;
    if (orderedDimen.quantity > 1) {
      return true;
    }
    return false;
  }

  void addQuantityOfProduct() {
    if (checkMaxQuantityAvailability()) {
      emit(
        state.copyWith(
            productDetails: state.productDetails.copyWith(
                dimension: state.productDetails.dimension.copyWith(
                    quantity: state.productDetails.dimension.quantity + 1))),
      );
    }
  }

  void removeQuantityOfProduct() {
    if (checkMinQuantityAvailability()) {
      emit(
        state.copyWith(
            productDetails: state.productDetails.copyWith(
                dimension: state.productDetails.dimension.copyWith(
                    quantity: state.productDetails.dimension.quantity - 1))),
      );
    }
  }
}
