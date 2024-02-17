import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/recomended_product/recomended_products_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

const itemWidth = 400;

class RecomendedProductCubit extends Cubit<RecomendedProductState> {
  RecomendedProductCubit()
      : super(RecomendedProductState.defaultRecomendedProductState()) {
    fetchRecomendedProducts();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final profileRepository = locate<ProfileRepository>();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  void moveToPreviousProduct(bool isMobile) {
    if (isMobile) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final currentOffset = scrollController.offset;
      final targetOffset = currentOffset - itemWidth;
      scrollController.animateTo(
        targetOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void moveToNextProduct(bool isMobile) {
    if (isMobile) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final currentOffset = scrollController.offset;
      final targetOffset = currentOffset + itemWidth;
      scrollController.animateTo(
        targetOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    }
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

  void toggleFavoriteForProduct(Product product) async {
    String? productId = product.id;
    if (productId == null) {
      return;
    }
    try {
      Product product =
          state.recomendedProducts.firstWhere((it) => it.id == productId);
      product.isFavorite = !product.isFavorite;
      emit(state.copyWith(recomendedProducts: state.recomendedProducts));
      bool success;
      Result<bool, Exception> response;
      if (product.isFavorite) {
        response = await profileRepository.addFavoriteProduct(productId);
      } else {
        response = await profileRepository.removeFavoriteProduct(productId);
      }
      success = response.tryGetSuccess() ?? false;
      if (!success) {
        product.isFavorite = !product.isFavorite;
        emit(state.copyWith(recomendedProducts: state.recomendedProducts));
      }
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    pageController.dispose();
    return super.close();
  }
}
