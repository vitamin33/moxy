import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';

class FooterRepository {
  FooterRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<dynamic, Exception>> sendFooterUserEmail(String email) async {
    try {
      final result =await client.sendFooterEmail(email);
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}