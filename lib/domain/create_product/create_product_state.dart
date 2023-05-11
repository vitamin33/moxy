import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/domain/models/product.dart';

part 'create_product_state.freezed.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState.initial({
    @Default(false) bool isLoading,
    @Default(false) bool isEdit,
    @Default('') String errorMessage,
    @Default([]) productById,
    @Default(0) int initialPage,
    @Default(0) int activePage,
    @Default('') String id,
    @Default('') String name,
    @Default('') String description,
    @Default(0) double costPrice,
    @Default(0.0) double salePrice,
    @Default('') String idName,
    @Default('') String color,
    @Default(0) int quantity,
    @Default(0) int index,
    @Default([]) List<String> images,
    @Default([]) List<Dimension> dimensions,
  }) = _Initial;

  const CreateProductState._();
}
