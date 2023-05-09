import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'create_product_state.freezed.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState.initial({
    @Default(false) bool isEdit,
    @Default([]) productById,
    @Default('') String id,
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


  const CreateProductState._();
}
