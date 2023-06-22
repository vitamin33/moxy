import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/domain/create_order/search_cities/search_cities_state.dart';
import 'package:moxy/domain/create_order/search_warehouse/search_warehouse_state.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

import '../../models/warehouse.dart';
import '../create_order_cubit.dart';

class SearchWarehouseCubit extends Cubit<SearchWarehouseState> {
  final NovaPoshtaClient apiService = locate<NovaPoshtaClient>();
  final WarehouseMapper mapper = locate<WarehouseMapper>();
  TextEditingController controller = TextEditingController();

  SearchWarehouseCubit()
      : super(SearchWarehouseState.defaultSearchWarehouseState());

  Future<List<Warehouse>> searchWarehouse(String searchTerm, city) async {
    emit(state.copyWith(isLoading: true));
    try {
      final cities = await apiService.fetchWarehouse(searchTerm, city);
      emit(state.copyWith(
          warehouseList: mapper.mapToWarehouseList(cities), isLoading: false));
      return mapper.mapToWarehouseList(cities);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
    return [];
  }

  String getCurrentSearchTerm() {
    return state.searchTerm ?? '';
  }

  Future<List<Warehouse>> clearWarehouse() async {
    try {
      emit(state.copyWith(warehouseList: []));
    } catch (e) {
      moxyPrint('Clear warehouseLIst');
    }
    return [];
  }

  void listenToSelectedCityChanges(context) {
  final createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);
  createOrderCubit.selectedCity.listen((city) {
    clearWarehouse();
  });
}
}
