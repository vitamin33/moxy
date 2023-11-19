import 'package:dio/dio.dart';
import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/data/http/user_service.dart';
import 'package:moxy/data/models/request/register_request.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/domain/models/user.dart';
import 'package:moxy/domain/roles.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../domain/mappers/user_mapper.dart';
import '../../services/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:multiple_result/multiple_result.dart';

import '../models/request/user_request.dart';

class AuthRepository {
  final UserService client = locate<UserService>();
  final userMapper = locate<UserMapper>();
  final tokenService = locate<TokenService>();

  Future<Result<Role, Exception>> loginWithCredentials(
      String mobileNumber, String password) async {
    try {
      final result = await client.login(mobileNumber, password);
      final accessToken = result?.accessToken;
      final refreshToken = result?.refreshToken;
      final userId = result?.userId;
      final userRole = result?.userRole;
      if (accessToken != null &&
          refreshToken != null &&
          userId != null &&
          userRole != null) {
        final prefs = await SharedPreferences.getInstance();
        tokenService.saveTokens(accessToken, refreshToken);
        await prefs.setString(userIdKey, userId);
        await prefs.setString(userRoleKey, userRole);
        return Result.success(_mapUserRole(userRole));
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
    } catch (e, stack) {
      moxyPrint('Failed logout.');
      moxyPrint(stack);
    }
  }

  Future<bool> checkLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    final containsAuthInfo = prefs.containsKey(accessTokenKey) &&
        prefs.containsKey(userIdKey) &&
        prefs.containsKey(userRoleKey);

    return containsAuthInfo;
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(userIdKey));
  }

  Future<Role?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userRole = prefs.getString(userRoleKey);
    return userRole?.let(_mapUserRole);
  }

  Future<Result<User, Exception>> createGuestUser(NetworkUser user) async {
    try {
      final resultCase = await client.createGuestUser(user);
      return Result.success(userMapper.mapToUser(resultCase));
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<List<User>, Exception>> getAllUsers() async {
    try {
      final resultUsers = await client.getAllUsers();
      return Result.success(resultUsers
          .map(
            (e) => userMapper.mapToUser(e),
          )
          .toList());
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Role _mapUserRole(String userRole) {
    switch (userRole) {
      case 'ADMIN':
        return Role.admin;
      case 'MANAGER':
        return Role.manager;
      case 'USER':
        return Role.user;
    }
    return Role.guest;
  }

  Future<Result<Headers, Exception>> editUser(NetworkProfileUser user) async {
    try {
      final resultCase = await client.editUser(user);
      return Result.success(resultCase);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<Headers, Exception>> editUserPassword(
      ProfilePassword password) async {
    try {
      final resultCase = await client
          .editUserPassword(userMapper.maptoNetworkPassword(password));
      return Result.success(resultCase);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  Future<Result<bool, Exception>> register(String firstName, String secondName,
      String mobileNumber, String email, String password) async {
    final resultCase = await client.register(NetworkRegister(
        firstName: firstName,
        secondName: secondName,
        mobileNumber: mobileNumber,
        email: email,
        password: password));
    if (resultCase) {
      return Result.success(resultCase);
    } else {
      return Result.error(Exception('error register'));
    }
  }

  Future<Result<bool, Exception>> sendConfirmationCode(
      String confirmationCode, String email) async {
    final resultCase = await client.sendConfirmationCode(
        NetworkConfirmationCode(
            email: email, confirmationCode: confirmationCode));
    if (resultCase) {
      return Result.success(resultCase);
    } else {
      return Result.error(Exception('error sendConfirmationCode'));
    }
  }

  Future<Result<bool, Exception>> resendConfirmationCode(String email) async {
    final resultCase = await client.resendConfirmationCode(email);
    if (resultCase) {
      return Result.success(resultCase);
    } else {
      return Result.error(Exception('error resendConfirmationCode'));
    }
  }

  Future<Result<bool, Exception>> createNewPassword(
    String email,
    String newPassword,
    String resetToken,
  ) async {
    final resultCase =
        await client.createNewPassword(email, newPassword, resetToken);
    if (resultCase) {
      return Result.success(resultCase);
    } else {
      return Result.error(Exception('error resendConfirmationCode'));
    }
  }

  Future<Result<bool, Exception>> resetPassword(String email) async {
    final resultCase = await client.resetPassword(email);
    if (resultCase) {
      return Result.success(resultCase);
    } else {
      return Result.error(Exception('error resetPassword'));
    }
  }
}
