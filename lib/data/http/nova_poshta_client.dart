import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/data/models/response/nova_network.dart';
import 'package:moxy/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<NovaNetworkEN>> fetchExpressWaybills(String apiKey) async {
    final currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

    const url = '$baseUrl/InternetDocument/getDocumentList';
    final body = {
      'apiKey': apiKey,
      'modelName': 'InternetDocument',
      'calledMethod': 'getDocumentList',
      'methodProperties': {
        'DateTimeFrom': currentDate,
        'DateTimeTo': currentDate,
        'GetFullList': '1'
      },
    };

    try {
      final response = await _dio.post(url, data: body);
      final jsonData = response.data;

      if (response.statusCode == 200 && jsonData['success']) {
        final documents = jsonData['data'];
        final enList = List<NovaNetworkEN>.from(
            documents.map((en) => NovaNetworkEN.fromJson(en)));
        return enList;
      } else {
        throw Exception('Failed to fetch Express Waybills');
      }
    } catch (e) {
      throw Exception('Failed to fetch Express Waybills: $e');
    }
  }

  Future<String?> getSavedNovaPostApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(novaPostApiKey);
  }

  Future<void> saveNovaPostApiKey(String apiKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(novaPostApiKey, apiKey);
    moxyPrint('Saved nova post api key: $apiKey');
  }
}
