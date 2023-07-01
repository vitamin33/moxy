import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/domain/admin/create_order/search_warehouse/search_warehouse_state.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

import '../../../models/warehouse.dart';

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
      final warehouseList = mapper.mapToWarehouseList(cities);
      emit(state.copyWith(warehouseList: warehouseList, isLoading: false));
      return warehouseList;
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
      emit(state.copyWith(
        warehouseList: [],
      ));
    } catch (e) {
      moxyPrint('Clear warehouseLIst');
    }
    return [];
  }
}
