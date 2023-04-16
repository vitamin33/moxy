import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'models/request/login_request.dart';
import 'models/response/login_response.dart';

class DioClient {
  static const String baseUrl = 'http://localhost:3000';
  //static const String baseUrl = 'https://miles-away-backend.herokuapp.com';
  static const String checkTokenValidUrl =
      '/api/v1/auth/check-token-valid-external';
  static const String loginUserUrl = '/api/v1/auth/login-user';
  static const String signUpUrl = '/api/v1/auth/create-new-user';
  static const String getUserUrl = '/api/v1/user';
  static const String getUserDashboardUrl = '/api/v1/user/dashboard';
  static const String redeemMilesdUrl = '/api/v1/user/redeem';
  static const String verifyAccountUrl =
      '/api/v1/auth/verification/verify-account';
  static const String checkSignatureUrl = '/api/v1/auth/signature';
  static const String nonceUrl = '/api/v1/auth/nonce';
  static const String checkWalletAddressUrl = '/api/v1/auth/check';

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

  Future<LoginResponse> login(
      String email, String password, bool rememberMe) async {
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
