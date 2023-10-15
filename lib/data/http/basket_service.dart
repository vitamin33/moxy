import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/request/mono_create_invoice_request.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/models/response/mono_create_invoice_response.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../environment.dart';

class BasketService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  BasketService(this._dio);

  Future<NetworkBasket?> getBasket() async {
    try {
      final response = await _dio.get('$baseUrl$getBasketUrl');
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return result;
    } on DioException catch (e) {
      moxyPrint(e);
      return null;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
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
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
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
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
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
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<NetworkCreateInvoiceResponse> startPayment(
      CreateInvoiceRequest createInvoice) async {
    try {
      _dio.options.headers['X-Token'] = Environment.monoAcquiringToken;
      _dio.options.headers['Content-Type'] = Headers.jsonContentType;
      _dio.options.headers['Accept'] = '*/*';
      final json = createInvoice.toJson();
      final response = await _dio.post(
        monoCreateInvoiceUrl,
        data: json,
      );
      final data = response.data;
      final result = NetworkCreateInvoiceResponse.fromJson(data);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
}
