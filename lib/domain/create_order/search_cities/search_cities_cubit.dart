import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/domain/create_order/search_cities/search_cities_state.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/services/get_it.dart';

class SearchCitiesCubit extends Cubit<SearchCitiesState> {
  final NovaPoshtaClient apiService = locate<NovaPoshtaClient>();
  final CityMapper mapper = locate<CityMapper>();
  TextEditingController controller = TextEditingController();

  SearchCitiesCubit() : super(SearchCitiesState.defaultSearchCitiesState());

  Future<List<City>> searchCities(String searchTerm) async {
    emit(state.copyWith(isLoading: true));

    try {
      final cities = await apiService.fetchCities(searchTerm);
      emit(state.copyWith(
          cityList: mapper.mapToCityList(cities), isLoading: false));
      return mapper.mapToCityList(cities);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
    return [];
  }

  String getCurrentSearchTerm() {
    return state.searchTerm ?? '';
  }
}
