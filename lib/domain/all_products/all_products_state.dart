import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'all_products_state.freezed.dart';

@freezed
class AllProductsState with _$AllProductsState {
  const factory AllProductsState.initial({
    @Default([]) List<Product> allProducts,
  }) = Initial;
  const factory AllProductsState.loading() = Loading;
  const factory AllProductsState.error([String? message]) = ErrorDetails;
}
