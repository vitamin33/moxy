import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial({
    @Default(0) int initialPage,
    @Default(0) int activePage,
    @Default('') String name,
    @Default('') String description,
    @Default(0) int warehouseQuantity,
    @Default(0) double costPrice,
    @Default(0.0) double salePrice,
    @Default('') String color,
    @Default([]) List<String> images,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _Initial;


  const ProductState._();
}
