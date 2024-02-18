import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/request/login_request.dart';
import 'package:moxy/data/models/request/register_request.dart';
import 'package:moxy/data/models/request/user_request.dart';
import 'package:moxy/data/models/response/login_response.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';
import 'package:multiple_result/multiple_result.dart';

class UserService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  UserService(this._dio);

  Future<LoginResponse?> login(String mobileNumber, String password) async {
    LoginRequest request =
        LoginRequest(mobileNumber: mobileNumber, password: password);
    try {
      Response response = await _dio.post(
        loginUserUrl,
        data: request.toJson(),
      );
      LoginResponse result = LoginResponse.fromJson(response.data);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<NetworkUser> createGuestUser(NetworkUser guest) async {
    try {
      Response response = await _dio.post(
        createGuestUserUrl,
        data: guest.toJson(),
      );
      NetworkUser result = NetworkUser.fromJson(response.data);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<List<NetworkUser>> getAllUsers() async {
    try {
      final response = await _dio.get('$baseUrl$allUsersUrl');
      final data = response.data;
      final userList = <NetworkUser>[];
      for (var value in (data as List)) {
        userList.add(NetworkUser.fromJson(value));
      }
      return userList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Headers> editUser(NetworkProfileUser user) async {
    try {
      Response response = await _dio.post(
        editUserUrl,
        data: user.toJson(),
      );
      Headers result = response.headers;
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Headers> editUserPassword(NetworkPasswordUser password) async {
    try {
      Response response = await _dio.post(
        editUserPasswordUrl,
        data: password.toJson(),
      );
      Headers result = response.headers;
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  //REGISTER
  Future<Result<bool, String>> register(NetworkRegister networkRegister) async {
    try {
      Response response = await _dio.post(
        registerUserUrl,
        data: networkRegister.toJson(),
      );
      if (response.statusCode == HttpStatus.created) {
        return const Result.success(true);
      } else {
        return const Result.error('Помилка при реєстрації');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.conflict) {
        return const Result.error(
            'Аккаунт з таким телефоном чи email-ом вже існує');
      } else {
        rethrow;
      }
    }
  }

  Future<Result<bool, String>> sendConfirmationCode(
      NetworkConfirmationCode networkConfirmationCode) async {
    try {
      Response response = await _dio.post(
        verifyUserUrl,
        data: networkConfirmationCode.toJson(),
      );
      if (response.statusCode == HttpStatus.created) {
        return const Result.success(true);
      } else {
        return const Result.error(
            'Не вдалося відправити код підтверження, спробуйте пізніше.');
      }
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<bool> resendConfirmationCode(String email) async {
    try {
      Response response = await _dio.post(
        resendVerifyUserUrl,
        data: {'email': email},
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createNewPassword(
    String email,
    String newPassword,
    String resetToken,
  ) async {
    try {
      Response response = await _dio.post(
        setNewPasswordUrl,
        data: {
          'email': email,
          'newPassword': newPassword,
          'resetToken': resetToken
        },
      );
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      Response response = await _dio.post(
        resetPasswordUrl,
        data: {'email': email},
      );
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } catch (e) {
      rethrow;
    }
  }
}
