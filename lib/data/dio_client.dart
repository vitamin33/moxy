import 'dart:convert';

import 'package:moxy/constants.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/utils/common.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:multiple_result/multiple_result.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api_path.dart';
import '../constant/order_constants.dart';
import 'models/request/create_order_request.dart';
import 'models/request/login_request.dart';
import 'models/request/create_product_request.dart';
import 'models/request/user_request.dart';
import 'models/response/all_orders_response.dart';
import 'models/response/login_response.dart';

class DioClient {
  static final DioClient instance = DioClient._private();
  late String baseUrl;

  final Dio _dio = Dio();

  DioClient._private() {
    baseUrl = Environment.apiUrl;
    if (baseUrl.isEmpty) {
      throw Exception('Unable to find BASE_URL parameter in env file.');
    }
    // Set default configs
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 10000; //10s
    _dio.options.receiveTimeout = 10000;

    // customization
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<LoginResponse?> login(String mobileNumber, String password) async {
    LoginRequest request =
        LoginRequest(mobileNumber: mobileNumber, password: password);

    LoginResponse result;
    try {
      Response response = await _dio.post(
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

  Future<CreateProduct?> createProduct(
    String name,
    String description,
    double costPrice,
    double salePrice,
    List<NetworkDimension> dimensions,
    List<String> images,
    String idName,
  ) async {
    final CreateProduct? result;
    List<MultipartFile> imageFiles = [];
    for (String image in images) {
      String fileName = basename(image);
      imageFiles.add(
        await MultipartFile.fromFile(
          image,
          filename: fileName,
        ),
      );
    }
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'costPrice': costPrice,
      'salePrice': salePrice,
      'dimensions': jsonDecode(jsonEncode(dimensions)),
      'images': imageFiles,
      'idName': idName
    });
    try {
      Response response = await _dio.post(
        createProductUrl,
        data: formData,
      );
      result = CreateProduct.fromJson(response.data);
    } catch (e) {
      moxyPrint('Request product :$e');
      return null;
    }
    return result;
  }

  Future<List<NetworkProduct>> allProducts() async {
    try {
      final response = await _dio.get(allProductsUrl);
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  Future<NetworkProduct> getProductById(String id) async {
    try {
      final response = await _dio.get('$baseUrl/products/$id');
      final data = response.data;
      final result = NetworkProduct.fromJson(data);
      return result;
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  Future<NetworkProduct?> editProduct(
      String? id,
      String name,
      String description,
      String idName,
      List<NetworkDimension> dimensions,
      double costPrice,
      double salePrice,
      List<String> images,
      editProductId) async {
    final NetworkProduct? result;
    List<MultipartFile> newImage = [];
    List<String> currentImage = [];
    for (String image in images) {
      if (image.contains('http')) {
        currentImage.add(image);
      } else {
        String fileName = basename(image);
        newImage.add(
          await MultipartFile.fromFile(
            image,
            filename: fileName,
          ),
        );
      }
    }
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'costPrice': costPrice,
      'salePrice': salePrice,
      'idName': idName,
      'newImages': newImage,
      'currentImages': currentImage,
      'dimensions': jsonDecode(jsonEncode(dimensions)),
    });
    try {
      Response response = await _dio.post(
        '$baseUrl/products/edit/$editProductId',
        data: formData,
      );
      result = NetworkProduct.fromJson(response.data);
    } catch (e) {
      moxyPrint('Request product :$e');
      return null;
    }
    return result;
  }

  // ORDERS

  Future<List<NetworkOrder>> allOrders(token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get('$baseUrl/orders');
      final data = response.data;
      final orderList = <NetworkOrder>[];
      for (var value in (data as List)) {
        orderList.add(NetworkOrder.fromJson(value));
      }
      return orderList;
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  Future<CreateOrder?> createOrder(
      DeliveryType deliveryType,
      PaymentType paymentType,
      int novaPostNumber,
      List<NetworkProduct> selectedProducts,
      NetworkClient client,
      String status,
      token) async {
    final CreateOrder? result;
    FormData formData = FormData.fromMap({
      'deliveryType': deliveryType.name,
      'paymentType': paymentType.name,
      'novaPostNumber': novaPostNumber,
      'products': selectedProducts,
      'client': client,
      'status': status
    });
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await _dio.post(
        createOrdersUrl,
        data: formData,
      );
      result = CreateOrder.fromJson(response.data);
    } catch (e) {
      moxyPrint('Request product :$e');
      return null;
    }
    return result;
  }

  // USERS

  Future<Result<NetworkUser, Exception>> createGuestUser(
      NetworkUser guest) async {
    final NetworkUser result;

    try {
      Response response = await _dio.post(
        createGuestUserUrl,
        data: guest.toJson(),
      );
      result = NetworkUser.fromJson(response.data);
    } catch (e) {
      print('Error during creating user: $e');

      return Result.error(_handleHttpException(e));
    }
    return Result.success(result);
  }

  Future<Result<List<NetworkUser>, Exception>> getAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(tokenKey);
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get('$baseUrl$allUsersUrl');
      final data = response.data;
      final userList = <NetworkUser>[];
      for (var value in (data as List)) {
        userList.add(NetworkUser.fromJson(value));
      }
      return Result.success(userList);
    } catch (e) {
      print('Error during gettting user list: $e');

      return Result.error(_handleHttpException(e));
    }
  }

  Exception _handleHttpException(Object e) {
    var message = e.toString();
    if (e is DioError) {
      message = e.response?.data['message'];
    }
    return Exception(message);
  }
}
