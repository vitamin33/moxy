import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../environment.dart';

class BasketService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  BasketService(this._dio);

  Future<Result<NetworkBasket, Exception>> getBasket() async {
    try {
      final response = await _dio.get('$baseUrl$getProductByIdUrl');
      final data = response.data;
      final result = NetworkBasket.fromJson(data);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
