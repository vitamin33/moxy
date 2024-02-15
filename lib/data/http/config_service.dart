import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/data/models/response/attributes_response.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../environment.dart';

class ConfigService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  ConfigService(this._dio);

  Future<Result<NetworkAttributesResponse, Exception>> getAttributes() async {
    try {
      final response = await _dio.get('$baseUrl$getAttributesUrl');
      final data = response.data;
      final jsonResponse = jsonEncode(data);
      saveNetworkAttributesResponse(jsonResponse);
      final result = NetworkAttributesResponse.fromJson(data);
      return Result.success(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveNetworkAttributesResponse(
      String jsonAttributesResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(attributesKey, jsonAttributesResponse);
  }
}
