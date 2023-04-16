import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../dio_client.dart';
import '../models/response/login_response.dart';

class AuthRepository {
  static DioClient client = DioClient.instance;

  static final AuthRepository instance = AuthRepository._private();

  AuthRepository._private();

  Future<LoginResponse> loginWithCredentials(
      String email, String password) async {
    try {
      final result = await client.login(email, password);
      final token = result.data?.token;
      final userId = result.data?.uniqueId;
      if (result.success && token != null && userId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, token);
        await prefs.setString(userIdKey, userId);
        print('Success login, saved token: $token');
      } else {
        print('Failed durring login!');
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('Successfult logout completed.');
    } catch (e) {
      print('Failed logout.');
    }
  }
}
