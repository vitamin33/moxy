import 'package:dio/dio.dart';
import 'package:moxy/data/models/response/network_city.dart';

class NovaPoshtaClient {
  static const baseUrl = 'https://api.novaposhta.ua/v2.0/json/';
  static const apiKey = '90603e83773eeb1f59952e4c85a53012';

  final Dio _dio = Dio();

  Future<List<NetworkCity>> fetchCities(String searchTerm) async {
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
        final cities = List<NetworkCity>.from(
            addresses.map((city) => NetworkCity.fromJson(city)));
        return cities;
      } else {
        throw Exception('Failed to fetch cities');
      }
    } catch (e) {
      throw Exception('Failed to fetch cities: $e');
    }
  }
}
