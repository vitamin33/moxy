import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/profile_mapper.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';
import '../http/dio_client.dart';

class ProfileRepository {
  ProfileRepository();
  final DioClient client = locate<DioClient>();
  final orderMapper = locate<OrderMapper>();
  final profileMapper = locate<ProfileMapper>();

  Future<Result<Profile, Exception>> getProfile() async {
    try {
      final result = await client.getProfile();
      final profile = profileMapper.mapToProfile(result);
      return Result.success(profile);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<List<Order>, Exception>> getProfileOrders() async {
    try {
      final result = await client.getProfileOrders();
      final profileHistoryOrders =
          orderMapper.mapToProfileOrderList(result.profileOrders!);
      return Result.success(profileHistoryOrders);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}
