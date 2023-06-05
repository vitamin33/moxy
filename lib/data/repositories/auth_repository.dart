import 'package:moxy/domain/models/user.dart';
import 'package:moxy/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../domain/mappers/user_mapper.dart';
import '../../services/get_it.dart';
import '../dio_client.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/request/user_request.dart';

class AuthRepository {
  static DioClient client = DioClient.instance;
  static final AuthRepository instance = AuthRepository._private();

  AuthRepository._private();

  final userMapper = locate<UserMapper>();

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

  Future<Result<User, Exception>> createGuestUser(NetworkUser user) async {
    final resultCase = await client.createGuestUser(user);
    return resultCase.when(
        (success) => Result.success(userMapper.mapToUser(success)),
        (error) => Result.error(error));
  }

  Future<Result<List<User>, Exception>> getAllUsers() async {
    final resultUsers = await client.getAllUsers();
    return resultUsers.when(
        (success) => Result.success(
              success
                  .map(
                    (e) => userMapper.mapToUser(e),
                  )
                  .toList(),
            ),
        (error) => Result.error(error));
  }
}
