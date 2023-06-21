import 'package:dio/dio.dart';
import 'package:moxy/data/models/response/nova_network.dart';

class NovaPoshtaClient {
  static const baseUrl = 'https://api.novaposhta.ua/v2.0/json/';
  static const apiKey = 'fc7b91aef89e3f6cfa32a846aa0c4ce9';

  final Dio _dio = Dio();

  Future<List<NovaNetworkCity>> fetchCities(String searchTerm) async {
    const url = '$baseUrl/Address/searchSettlements';
    final body = {
      'apiKey': apiKey,
      'modelName': 'Address',
      'calledMethod': 'searchSettlements',
      'methodProperties': {
        'CityName': searchTerm,
        'Limit': 10,
      },
    };

    try {
      final response = await _dio.post(url, data: body);
      final jsonData = response.data;

      if (response.statusCode == 200 && jsonData['success']) {
        final addresses = jsonData['data'][0]['Addresses'];
        final cities = List<NovaNetworkCity>.from(
            addresses.map((city) => NovaNetworkCity.fromJson(city)));
        return cities;
      } else {
        throw Exception('Failed to fetch cities');
      }
    } catch (e) {
      throw Exception('Failed to fetch cities: $e');
    }
  }

  Future<List<NovaNetworkWarehouse>> fetchWarehouse(
      String searchTerm, city) async {
    const url = '$baseUrl/Address/getWarehouses';
    final body = {
      'apiKey': apiKey,
      'modelName': 'Address',
      'calledMethod': 'getWarehouses',
      'methodProperties': {
        'CityRef': city,
        'Limit': 10,
        "Language": "UA",
        'FindByString': searchTerm
      },
    };

    try {
      final response = await _dio.post(url, data: body);
      final jsonData = response.data;

      if (response.statusCode == 200 && jsonData['success']) {
        final description = jsonData['data'];
        final warehouseList = List<NovaNetworkWarehouse>.from(description
            .map((warehouse) => NovaNetworkWarehouse.fromJson(warehouse)));
        return warehouseList;
      } else {
        throw Exception('Failed to fetch cities');
      }
    } catch (e) {
      throw Exception('Failed to fetch cities: $e');
    }
  }
}
