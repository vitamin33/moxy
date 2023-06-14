import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/domain/models/user.dart';
import 'package:moxy/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../domain/mappers/user_mapper.dart';
import '../../services/get_it.dart';
import '../http/dio_client.dart';
// ignore: depend_on_referenced_packages
import 'package:multiple_result/multiple_result.dart';

import '../models/request/user_request.dart';

class AuthRepository {
  final DioClient client = locate<DioClient>();
  final userMapper = locate<UserMapper>();
  final tokenService = locate<TokenService>();

  Future<Result<SharedPreferences, Exception>> loginWithCredentials(
      String mobileNumber, String password) async {
    try {
      final result = await client.login(mobileNumber, password);
      final accessToken = result?.accessToken;
      final refreshToken = result?.refreshToken;
      final userId = result?.userId;
      if (accessToken != null && refreshToken != null && userId != null) {
        final prefs = await SharedPreferences.getInstance();
        tokenService.saveTokens(accessToken, refreshToken);
        await prefs.setString(userIdKey, userId);
        return Result.success(prefs);
      } else {
        moxyPrint('Failed durring login!');
        return Result.error(Exception('Login failed.'));
      }
    } catch (e) {
      return Result.error(Exception('Login failed.'));
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
    return prefs.containsKey(accessTokenKey) && prefs.containsKey(userIdKey);
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
