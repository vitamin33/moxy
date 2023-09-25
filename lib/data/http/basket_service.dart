import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../environment.dart';

class BasketService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  BasketService(this._dio);

  Future<Result<NetworkBasket, Exception>> getBasket() async {
    try {
      final response = await _dio.get('$baseUrl $getBasketUrl');
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<NetworkBasket, Exception>> removeProductFromBasket(
      NetworkRemoveProduct remove) async {
    try {
      _dio.options.headers['Content-Type'] = Headers.jsonContentType;
      final response = await _dio.post('$baseUrl$removeProductBasketUrl',
          data: remove.toJson());
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<NetworkBasket, Exception>> addOrChangeQuantityOfProduct(
      NetworkAddOrChange change) async {
    try {
      _dio.options.headers['Content-Type'] = Headers.jsonContentType;
      final response =
          await _dio.post('$baseUrl$changeBasketUrl', data: change.toJson());
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<Headers, Exception>> addProductToBasket(
      NetworkAddOrChange change) async {
    try {
      _dio.options.headers['Content-Type'] = Headers.jsonContentType;
      final response =
          await _dio.post('$baseUrl$changeBasketUrl', data: change.toJson());
      final result = response.headers;
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<NetworkBasket, Exception>> startPayment() async {
    try {
      _dio.options.headers['Content-Type'] = Headers.jsonContentType;
      final response = await _dio.post('$baseUrl$changeBasketUrl');
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
