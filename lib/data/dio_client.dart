import 'package:moxy/utils/common.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constant/api_path.dart';
import 'models/request/login_request.dart';
import 'models/request/create_product_request.dart';
import 'models/response/login_response.dart';

class DioClient {
  static const String baseUrl = 'http://10.0.2.2:3000';
  // static const String baseUrl = 'http://localhost:3000';
  static const String loginUserUrl = '/auth/login';

  static final DioClient instance = DioClient._private();

  final Dio _dio = Dio();

  DioClient._private() {
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

  Future<LoginResponse?> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);

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
    int warehouseQuantity,
    double costPrice,
    double salePrice,
    String color,
    List<String> images,
  ) async {
    final CreateProduct result;
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
      'warehouseQuantity': warehouseQuantity,
      'color': color,
      'images': imageFiles
    });
    try {
      Response response = await _dio.post(
        createProductApiPath,
        data: formData,
      );
      result = CreateProduct.fromJson(response.data);
      return result;
    } catch (e) {
      moxyPrint('Request product :$e');
      return null;
    }
  }
}
