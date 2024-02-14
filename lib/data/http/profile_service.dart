import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/request/subscribe_request.dart';
import 'package:moxy/data/models/request/user_request.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/models/response/error_response.dart';
import 'package:moxy/data/models/response/profile_response.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';
import 'package:multiple_result/multiple_result.dart';

class ProfileService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  ProfileService(this._dio);

  //PROFILE
  Future<NetworkProfile> getProfile() async {
    try {
      final response = await _dio.get('$baseUrl $getProfileUrl');
      final profile = NetworkProfile.fromJson(response.data);
      return profile;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<ProfileOrdersResponse> getProfileOrders() async {
    try {
      final response = await _dio.get('$baseUrl$getProfileOrdersUrl');
      final data = response.data;
      final orderList = ProfileOrdersResponse.fromJson(data);
      return orderList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getFavoriteProducts() async {
    try {
      final response = await _dio.get('$baseUrl $getFavoriteUrl');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addFavoriteProduct(String productId) async {
    try {
      final response = await _dio.post('$baseUrl$getFavoriteUrl/$productId');
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFavoriteProduct(String productId) async {
    try {
      final response = await _dio.delete('$baseUrl$getFavoriteUrl/$productId');
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } catch (e) {
      rethrow;
    }
  }

// EDIT USER
  Future<Result<Headers, Exception>> editUser(NetworkProfileUser user) async {
    final Headers? result;

    try {
      Response response = await _dio.post(
        editUserUrl,
        data: user.toJson(),
      );
      result = response.headers;
    } catch (e) {
      rethrow;
    }
    return Result.success(result);
  }

  Future<Result<Headers, Exception>> editUserPassword(
      NetworkPasswordUser password) async {
    final Headers result;
    try {
      Response response = await _dio.post(
        editUserPasswordUrl,
        data: password.toJson(),
      );
      result = response.headers;
    } catch (e) {
      rethrow;
    }
    return Result.success(result);
  }

  Future<bool> subscribeLead(String email, String firstName) async {
    try {
      final request = SubscribeRequest(email: email, firstName: firstName);
      final response =
          await _dio.post('$baseUrl$subscribeLeadUrl', data: request.toJson());
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } on DioException catch (error) {
      if (error.response != null) {
        final errorResponse = ErrorResponse.fromJson(error.response!.data);
        throw Exception(errorResponse.message);
      } else {
        throw Exception('Unknown error occurred. ${error.toString()}');
      }
    }
  }
}
