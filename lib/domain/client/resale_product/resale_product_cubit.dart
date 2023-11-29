import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/client/resale_product/resale_products_state.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class ResaleProductCubit extends Cubit<ResaleProductState> {
  ResaleProductCubit() : super(ResaleProductState.defaultResaleProductState()) {
    fetchResaleProducts();
  }

  final productRepository = locate<ProductRepository>();
  final productMapper = locate<ProductMapper>();
  final ScrollController scrollController = ScrollController();

  void moveToPreviousProduct() {
    final currentOffset = scrollController.offset;
    final itemWidth = 400;
    final targetOffset = currentOffset - itemWidth;

    scrollController.animateTo(
      targetOffset,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void moveToNextProduct() {
    final currentOffset = scrollController.offset;
    final itemWidth = 400;
    final targetOffset = currentOffset + itemWidth;

    scrollController.animateTo(
      targetOffset,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void fetchResaleProducts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productRepository.getRecomendedProducts();
      result.when((success) {
        final allProductsList = productMapper.mapToProductList(success);
        emit(state.copyWith(resaleProducts: allProductsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allSellingProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
