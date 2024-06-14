import 'dart:io';

import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/data/models/request/register_request.dart';
import 'package:moxy/data/models/response/products_stats_response.dart';
import 'package:moxy/data/models/response/review_response.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation/navigation_service.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/utils/common.dart';
// ignore: depend_on_referenced_packages
import 'package:multiple_result/multiple_result.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constant/api_path.dart';
import '../models/response/all_promos_response.dart';
import '../models/response/dashboard_response.dart';

class DioClient {
  late String baseUrl;

  final Dio dio = locate<Dio>();

  final TokenService _tokenService = locate<TokenService>();
  final NavigationService _navigator = locate<NavigationService>();

  DioClient() {
    baseUrl = Environment.apiUrl;
    if (baseUrl.isEmpty) {
      throw Exception('Unable to find BASE_URL parameter in env file.');
    }

    // Set default configs
    dio.options.baseUrl = baseUrl;

    dio.options.connectTimeout = const Duration(seconds: 20); //15s
    dio.options.receiveTimeout = const Duration(seconds: 20);

    // customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add the access token to the request headers
        final String? accessToken = await _tokenService.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401 &&
            !error.requestOptions.path.endsWith('refresh-token')) {
          // Token expired or invalid, attempt to refresh it
          Result<String, Exception> newAccessTokenResult =
              await _tokenService.refreshAccessToken();
          if (newAccessTokenResult.isSuccess()) {
            final accessToken = newAccessTokenResult.tryGetSuccess();
            // Retry the original request with the new access token
            error.requestOptions.headers['Authorization'] =
                'Bearer $accessToken';
            final options = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
              responseType: error.requestOptions.responseType,
            );
            final response =
                await dio.request(error.requestOptions.path, options: options);
            return handler.resolve(response);
          } else {
            moxyPrint(
                'Error during refreshing access token: ${error.toString()}');
            // _navigator.push(RouterProvider.loginPath());
            return handler.reject(error);
          }
        } else if (error.response?.statusCode == 401) {
          _navigator.push(RouterProvider.loginPath());
        }
        return handler.next(error);
      },
    ));
  }

  Exception _handleHttpException(Object e) {
    var message = e.toString();
    if (e is DioException) {
      message = e.response?.data['message'];
    }
    return Exception(message);
  }

// DASHBOARD

  Future<NetworkDashboard> getDashboard(
      DateTime? fromDate, DateTime? toDate) async {
    try {
      final Map<String, String> requestData;

      if (toDate != null || fromDate != null) {
        requestData = {
          "fromDate": fromDate.toString(),
          "toDate": toDate.toString()
        };
      } else {
        requestData = {
          "fromDate": "2023-05-22T12:00:00.000Z",
          "toDate": "2023-07-21T12:00:00.000Z"
        };
      }

      final response = await dio.post(ordersDashboardUrl, data: requestData);
      final data = response.data;
      final result = NetworkDashboard.fromJson(data);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      throw Exception('Failed to load product: $e');
    }
  }

  Future<NetworkProductStats> getProductStats(
      DateTime? fromDate, DateTime? toDate) async {
    try {
      final Map<String, String> requestData;

      if (toDate != null || fromDate != null) {
        requestData = {
          "fromDate": fromDate.toString(),
          "toDate": toDate.toString()
        };
      } else {
        requestData = {
          "fromDate": "2023-05-22T12:00:00.000Z",
          "toDate": "2023-07-21T12:00:00.000Z"
        };
      }

      final response = await dio.post(productStatsUrl, data: requestData);
      final data = response.data;
      final result = NetworkProductStats.fromJson(data);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      throw Exception('Failed to load product stats: $e');
    }
  }

// WEB

// FOOTER
  Future<Result<Headers, Exception>> sendFooterEmail(String email) async {
    final Headers? result;
    try {
      Response response = await dio.post(
        sendFooterEmailUrl,
        data: email,
      );
      result = response.headers;
    } catch (e) {
      moxyPrint('Error send user email: $e');
      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  // PROMO
  Future<List<NetworkPromos>> getPromos() async {
    try {
      final response = await dio.get('$baseUrl$getPromosUrl');
      final data = response.data;
      final promosList = <NetworkPromos>[];
      for (var value in (data as List)) {
        promosList.add(NetworkPromos.fromJson(value));
      }
      return promosList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  //REGISTER
  Future<bool> register(NetworkRegister networkRegister) async {
    try {
      Response response = await dio.post(
        registerUserUrl,
        data: networkRegister.toJson(),
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.conflict) {
        return true;
      } else {
        rethrow;
      }
    }
  }

  Future<bool> sendConfirmationCode(
      NetworkConfirmationCode networkConfirmationCode) async {
    try {
      Response response = await dio.post(
        verifyUserUrl,
        data: networkConfirmationCode.toJson(),
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<bool> resendConfirmationCode(String email) async {
    try {
      Response response = await dio.post(
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

  Future<bool> changePasswordWithMobile(String email) async {
    try {
      Response response = await dio.post(
        setNewPasswordUrl,
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

  Future<List<NetworkReview>> fetchReviews() async {
    try {
      Response response = await dio.get(
        getReviewsUrl,
      );
      final data = response.data;
      final orderList = <NetworkReview>[];
      for (var value in (data as List)) {
        orderList.add(NetworkReview.fromJson(value));
      }
      return orderList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<ProductReviewsResponse> fetchReviewStatsForProduct(
      String productId) async {
    try {
      Response response = await dio.get(
        '$getReviewProductStatsUrl/$productId',
      );
      final data = response.data;

      return ProductReviewsResponse.fromJson(data);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
}
