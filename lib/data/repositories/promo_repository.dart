import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';

class PromoRepository {
  PromoRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<dynamic, Exception>> getPromo() async {
    try {
      final result =await client.getAllPromo();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}