import 'package:moxy/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../dio_client.dart';
import '../models/response/login_response.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepository {
  static DioClient client = DioClient.instance;

  static final AuthRepository instance = AuthRepository._private();

  AuthRepository._private();

  Future<Result<SharedPreferences, Exception>> loginWithCredentials(
      String email, String password) async {
    try {
      final result = await client.login(email, password);
      final token = result?.token;
      final userId = result?.userId;
      if (token != null && userId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, token);
        await prefs.setString(userIdKey, userId);
        moxyPrint('Success login, saved token: $token');
        return Result.success(prefs);
      } else {
        moxyPrint('Failed durring login!');
        return Result.error(Exception('sdsd'));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      moxyPrint('Successfult logout completed.');
    } catch (e) {
      moxyPrint('Failed logout.');
    }
  }

  Future<bool> checkLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(tokenKey) && prefs.containsKey(userIdKey);
  }
}
