import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/review_repository.dart';
import 'package:moxy/domain/client/product_details/product_details_effect.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/review_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';

class ProductDetailsCubit
    extends CubitWithEffects<ProductDetailsState, UiEffect> {
  final String? productId;
  ProductDetailsCubit({required this.productId})
      : super(ProductDetailsState.defaultProductDetailsState()) {
    productId?.let(
      (id) {
        fetchReviewStatsForProduct(id);
        getProductsDetails(id);
      },
    );
  }

  final productRepository = locate<ProductRepository>();
  final reviewsRepository = locate<ReviewRepository>();
  final productMapper = locate<ProductMapper>();
  final reviewMapper = locate<ReviewMapper>();

  void getProductsDetails(String productId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getProductsDetails(productId);
      result.when((success) {
        final productDetails = productMapper.mapToProductDetails(success);
        final images =
            _updateSelectedImagesList(productDetails.product.dimensions);
        emit(state.copyWith(
          allImages: images,
          productDetails: productDetails,
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

  void fetchReviewStatsForProduct(String productId) async {
    try {
      final result =
          await reviewsRepository.getReviewsStatsForProduct(productId);
      result.when((success) {
        final reviewStats = reviewMapper.mapToReviewStats(success);
        emit(state.copyWith(reviewStats: reviewStats));
      }, (error) {
        emit(state.copyWith(isLoading: false));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  List<ImagePath> _updateSelectedImagesList(List<Dimension> dimensions) {
    final dimens = dimensions;
    bool allDimensionsSelected =
        dimens.any((dimension) => dimension.isSelected);
    List<ImagePath> allImages;

    if (allDimensionsSelected) {
      allImages = dimens
          .where((dimension) => dimension.isSelected)
          .expand((dimension) => dimension.images)
          .toList();
    } else {
      allImages = dimens.expand((dimension) => dimension.images).toList();
    }

    return allImages;
  }

  void setSeletedColor(Dimension selectedDimension) {
    final updatedSelectedProductDimens =
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
      images: selectedDimension.images,
    );
    final images = _updateSelectedImagesList(updatedSelectedProductDimens);
    emit(state.copyWith(
        allImages: images,
        productDetails: state.productDetails.copyWith(
          dimension: updateSelectedDimension,
          product: state.productDetails.product.copyWith(
            dimensions: updatedSelectedProductDimens,
          ),
        )));
  }

  bool checkMaxQuantityAvailability() {
    Dimension orderedDimen = state.productDetails.selectedDimension;
    Dimension productDimen = state.productDetails.product.dimensions
        .firstWhere((d) => d.color.id == orderedDimen.color.id);
    if (orderedDimen.quantity < productDimen.quantity) {
      return true;
    }
    return false;
  }

  bool checkMinQuantityAvailability() {
    Dimension orderedDimen = state.productDetails.selectedDimension;
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
                dimension: state.productDetails.selectedDimension.copyWith(
                    quantity:
                        state.productDetails.selectedDimension.quantity + 1))),
      );
    }
  }

  void removeQuantityOfProduct() {
    if (checkMinQuantityAvailability()) {
      emit(
        state.copyWith(
            productDetails: state.productDetails.copyWith(
                dimension: state.productDetails.selectedDimension.copyWith(
                    quantity:
                        state.productDetails.selectedDimension.quantity - 1))),
      );
    }
  }
}
