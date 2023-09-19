import 'package:moxy/data/models/response/profile_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';

class ProfileRepository {
  ProfileRepository();
  final DioClient client = locate<DioClient>();

  Future<Result<NetworkProfile, Exception>> getProfile() async {
    try {
      final result = await client.getProfile();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}
