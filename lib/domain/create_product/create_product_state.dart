import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
// import 'package:moxy/data/models/request/create_product_request.dart';
// import 'package:moxy/data/models/response/all_products_response.dart';

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

// @freezed
// class Dimension with _$Dimension {
//   const factory Dimension({
//     @Default('') String color,
//     @Default(0) int quantity,
//   }) = _Dimension;

//   factory Dimension.fromJson(Map<String, dynamic> json) =>
//       _$DimensionFromJson(json);
//   Map<String, dynamic> toJson() => _$DimensionToJson(this);
// }


// Map<String, dynamic> DimensionToJson(Dimension instance) => <String, dynamic>{
//       'color': instance.color,
//       'quantity': instance.quantity,
//     };