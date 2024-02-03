import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/data/models/response/login_response.dart';
import 'package:moxy/data/models/response/token_response.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final Dio _dio;

  TokenService(this._dio);

  Future<String?> getAccessToken() async {
    // Retrieve the access token from secure storage or SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    // Save the tokens securely in storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
    moxyPrint('Saved accessToken: $accessToken');
    moxyPrint('Saved refreshToken: $refreshToken');
  }

  Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    moxyPrint('Saved accessToken: $accessToken');
  }

  Future<String?> getRefreshToken() async {
    // Retrieve the refresh token from secure storage or SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  Future<void> clearTokens() async {
    // Clear the tokens from storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
  }

  Future<Result<String, Exception>> refreshAccessToken() async {
    try {
      final String? refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        final data = {
          'refreshToken': refreshToken,
        };

        final baseUrl = Environment.apiUrl;
        final Response<Map<String, dynamic>> response = await _dio.post(
          '$baseUrl/auth/refresh-token',
          data: data,
        );

        final tokenResponse = TokenResponse.fromJson(response.data!);
        await saveAccessToken(tokenResponse.accessToken);

        return Result.success(tokenResponse.accessToken);
      }
    } on DioException {
      return Result.error(Exception('Error refreshing access token.'));
    } catch (e) {
      moxyPrint('Error refreshing token: $e');
      return Result.error(Exception('Error refreshing access token.'));
    }

    return Result.error(Exception('Error refreshing access token.'));
  }

  // GUEST
  Future<LoginResponse?> generateAndSaveGuestToken() async {
    try {
      final baseUrl = Environment.apiUrl;
      Response response = await _dio.post('$baseUrl$guestTokenUrl');
      int code = response.statusCode ?? 0;
      if (code.isSuccessful()) {
        LoginResponse result = LoginResponse.fromJson(response.data);
        final prefs = await SharedPreferences.getInstance();
        saveAccessToken(result.accessToken);
        await prefs.setString(userIdKey, result.userId);
        await prefs.setString(userRoleKey, result.userRole);
        return result;
      } else {
        return null;
      }
    } on DioException catch (e, stack) {
      moxyPrint(stack);
      return null;
    }
  }
}
