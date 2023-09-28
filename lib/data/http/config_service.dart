import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/response/attributes_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../environment.dart';

class ConfigService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  ConfigService(this._dio);

  Future<Result<NetworkAttributesResponse, Exception>> getAttributes() async {
    try {
      final response = await _dio.get('$baseUrl$getAttributesUrl');
      final data = response.data;
      final result = NetworkAttributesResponse.fromJson(data);
      return Result.success(result);
    } catch (e) {
      rethrow;
    }
  }
}
