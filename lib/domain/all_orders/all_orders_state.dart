import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

import '../../data/models/response/all_orders_response.dart';

part 'all_orders_state.freezed.dart';

@freezed
class AllOrdersState with _$AllOrdersState {
  const factory AllOrdersState.initial({
    @Default([]) List<Order> allOrders,
  }) = Initial;
  const factory AllOrdersState.loading() = Loading;
  const factory AllOrdersState.error([String? message]) = ErrorDetails;
}