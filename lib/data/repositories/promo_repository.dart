import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';
import '../models/response/all_promos_response.dart';

class PromoRepository {
  PromoRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<List<NetworkPromos>, Exception>> getPromo() async {
    try {
      final result =await client.getPromos();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}