import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import 'package:moxy/components/base_state.dart';
import 'package:moxy/constant/route_name.dart';
import 'package:moxy/data/models/product.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/image_picker_service.dart';
import 'package:moxy/services/navigation_service.dart';
import 'package:moxy/utils/common.dart';
import 'package:random_string/random_string.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial({
      @Default(0) int initialPage,
      @Default(0) int activePage,
      @Default('') String name,
      @Default('') String description,
      @Default(0) int costPrice,
      @Default(0.0) double regularPrice,
      @Default(0.0) double salePrice,
      @Default('') String color,
      @Default('') String image,
      // @Default(File('')) File image,
      }) = _Initial;

  // const factory ProductState.product({

  // }) = _Product;

  const ProductState._();
}

      // @Default(Pro()) Pro state
// @Default([0]) List<int> visitedPages,
// @Default( '') CreateProduct product
// @Default({})  CreateProduct product,

// class Pro {
//   const Pro();
// }

// class Product extends Pro {
//   Product(
//       {required this.name,
//       required this.description,
//       required this.costPrice,
//       required this.regularPrice,
//       required this.salePrice,
//       required this.color,
//       required this.image});
//   final String name ;
//   final String description ;
//   final int costPrice;
//   final double regularPrice ;
//   final double salePrice ;
//   final String color ;
//   final String image ;
// }

// @freezed
// class ProductState  {
//    factory ProductState.initial({
//     @Default({}) CreateProduct product,
//     // @Default("") String descripti,
//     // @Default(State.Initial) State state,
//     // @Default('') String errorMessage,
//   })  _Initial;
// }




