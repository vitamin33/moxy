import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'models/request/login_request.dart';
import 'models/response/login_response.dart';

class DioClient {
  static const String baseUrl = 'http://localhost:3000';
  static const String loginUserUrl = '/auth/login';

  static final DioClient instance = DioClient._private();

  final Dio _dio = Dio();

  DioClient._private() {
    // Set default configs
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000; //10s
    _dio.options.receiveTimeout = 10000;

    // customization
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<LoginResponse> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);

    LoginResponse result = LoginResponse(false, "Failed to login.", null);
    try {
      Response response = await _dio.post(
        loginUserUrl,
        data: request.toJson(),
      );

      print('Login response: ${response.data}');

      result = LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      final res = e.response;
      if (res != null) {
        result.message = LoginResponse.fromJson(res.data).message;
      }
      return result;
    } catch (e) {
      print('During login: $e');
      return result;
    }
    return result;
  }
}
