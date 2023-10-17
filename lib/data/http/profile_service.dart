import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/models/response/profile_response.dart';
import 'package:moxy/environment.dart';

class ProfileService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  ProfileService(this._dio);

  //PROFILE
  Future<NetworkProfile> getProfile() async {
    try {
      final response = await _dio.get('$baseUrl $getProfileUrl');
      final profile = NetworkProfile.fromJson(response.data);
      return profile;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<ProfileOrdersResponse> getProfileOrders() async {
    try {
      final response = await _dio.get('$baseUrl$getProfileOrdersUrl');
      final data = response.data;
      final orderList = ProfileOrdersResponse.fromJson(data);
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getFavoriteProducts() async {
    try {
      final response = await _dio.get('$baseUrl $getFavoriteUrl');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }
}
