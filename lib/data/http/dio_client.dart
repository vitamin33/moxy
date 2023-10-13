import 'dart:io';

import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/data/models/request/find_orders_request.dart';
import 'package:moxy/data/models/request/register_request.dart';
import 'package:moxy/domain/models/filter_order_param.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
// ignore: depend_on_referenced_packages
import 'package:multiple_result/multiple_result.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constant/api_path.dart';
import '../models/request/create_order_request.dart';
import '../models/request/edit_order_request.dart';
import '../models/request/login_request.dart';
import '../models/request/user_request.dart';
import '../models/response/all_orders_response.dart';
import '../models/response/all_promos_response.dart';
import '../models/response/dashboard_response.dart';
import '../models/response/login_response.dart';
import '../models/response/profile_response.dart';

class DioClient {
  late String baseUrl;

  final Dio dio = locate<Dio>();

  final TokenService _tokenService = locate<TokenService>();

  DioClient() {
    baseUrl = Environment.apiUrl;
    if (baseUrl.isEmpty) {
      throw Exception('Unable to find BASE_URL parameter in env file.');
    }

    // Set default configs
    dio.options.baseUrl = baseUrl;

    dio.options.connectTimeout = Duration(seconds: 15); //15s
    dio.options.receiveTimeout = Duration(seconds: 15);

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
        if (error.response?.statusCode == 401) {
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
            return handler.reject(error);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<LoginResponse?> login(String mobileNumber, String password) async {
    LoginRequest request =
        LoginRequest(mobileNumber: mobileNumber, password: password);
    LoginResponse result;
    try {
      Response response = await dio.post(
        loginUserUrl,
        data: request.toJson(),
      );
      result = LoginResponse.fromJson(response.data);
    } catch (e) {
      moxyPrint('During login: $e');
      return null;
    }
    return result;
  }

  // ORDERS

  Future<List<NetworkOrder>> paginatedAllOrders([int page = 1]) async {
    try {
      final response = await dio.get('$baseUrl$allOrdersUrl?page=$page');
      final data = response.data;
      final orderList = <NetworkOrder>[];
      for (var value in (data as List)) {
        orderList.add(NetworkOrder.fromJson(value));
      }
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkOrder>> paginatedFilterOrders(FilterOrderParams params,
      [int page = 1]) async {
    FindOrders find =
        FindOrders(statuses: [], paymentTypes: [], deliveryTypes: []);
    final deliveryType = params.deliveryType;
    if (deliveryType != FilterDeliveryType.empty) {
      find.deliveryTypes.add(deliveryType.capitalizedName);
    }
    final paymentType = params.paymentType;
    if (paymentType != FilterPaymentType.empty) {
      find.paymentTypes.add(paymentType.capitalizedName);
    }
    final statuses = params.statuses;
    if (statuses.isNotEmpty) {
      for (var status in statuses) {
        find.statuses.add(status.statusValue.name);
      }
    }
    final dateRange = params.dateRange?.toString();
    final startData = dateRange?.split(' - ')[0].split(' ')[0];
    find.fromDate = startData;
    final endData = dateRange?.split(' - ')[1].split(' ')[0];
    find.toDate = endData;

    try {
      final response = await dio.post(
        '$baseUrl$findOrdersUrl?page=$page',
        data: find.toJson(),
      );
      final data = response.data;
      final orderList = <NetworkOrder>[];
      for (var value in (data as List)) {
        orderList.add(NetworkOrder.fromJson(value));
      }
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<NetworkOrder> getOrderById(String orderId) async {
    try {
      final response = await dio.get('$baseUrl$orderByIdUrl$orderId');
      final data = response.data;
      return NetworkOrder.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Result<Headers, Exception>> createOrder(CreateOrder order) async {
    final Headers? result;
    final data = order.toJson();
    try {
      Response response = await dio.post(
        createOrdersUrl,
        data: data,
      );
      result = response.headers;
    } catch (e) {
      moxyPrint('Error during creating order: $e');
      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  Future<Result<Headers, Exception>> editOrder(EditOrder order) async {
    final Headers? result;
    final data = order.toJson();
    try {
      Response response = await dio.post(
        editOrdersUrl,
        data: data,
      );
      result = response.headers;
    } catch (e) {
      moxyPrint('Error during creating order: $e');
      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  Future<Result<Headers, Exception>> editOrderStatus(
      EditStatusOrder order) async {
    final Headers? result;
    final data = order.toJson();
    try {
      Response response = await dio.post(
        editOrdersUrl,
        data: data,
      );
      result = response.headers;
    } catch (e) {
      moxyPrint('Error during edit status order: $e');
      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  // USERS

  Future<Result<NetworkUser, Exception>> createGuestUser(
      NetworkUser guest) async {
    final NetworkUser result;

    try {
      Response response = await dio.post(
        createGuestUserUrl,
        data: guest.toJson(),
      );
      result = NetworkUser.fromJson(response.data);
    } catch (e) {
      moxyPrint('Error during creating user: $e');

      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  Future<Result<List<NetworkUser>, Exception>> getAllUsers() async {
    try {
      final response = await dio.get('$baseUrl$allUsersUrl');
      final data = response.data;
      final userList = <NetworkUser>[];
      for (var value in (data as List)) {
        userList.add(NetworkUser.fromJson(value));
      }
      return Result.success(userList);
    } catch (e) {
      moxyPrint('Error during gettting user list: $e');

      return Result.error(_handleHttpException(e));
    }
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
      final requestData;

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
    } catch (e) {
      throw Exception('Failed to load product: $e');
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
      final response = await dio.get('$baseUrl $getPromosUrl');
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

  //PROFILE
  Future<NetworkProfile> getProfile() async {
    try {
      final response = await dio.get('$baseUrl $getProfileUrl');
      final profile = NetworkProfile.fromJson(response.data);
      return profile;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<ProfileOrdersResponse> getProfileOrders() async {
    try {
      final response = await dio.get('$baseUrl $getProfileOrdersUrl');
      final data = response.data;
      final orderList = ProfileOrdersResponse.fromJson(data);
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

// EDIT USER
  Future<Result<Headers, Exception>> editUser(NetworkProfileUser user) async {
    final Headers? result;

    try {
      Response response = await dio.post(
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
      Response response = await dio.post(
        editUserPasswordUrl,
        data: password.toJson(),
      );
      result = response.headers;
    } catch (e) {
      rethrow;
    }
    return Result.success(result);
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
        editUserPassworWithMobiledUrl,
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
}
