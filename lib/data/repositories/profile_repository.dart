import 'package:moxy/data/http/profile_service.dart';
import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/profile_mapper.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';

class ProfileRepository {
  ProfileRepository();
  final ProfileService client = locate<ProfileService>();
  final orderMapper = locate<OrderMapper>();
  final productMapper = locate<ProductMapper>();
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
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<List<Product>, Exception>> getFavoriteProducts() async {
    try {
      final result = await client.getFavoriteProducts();
      final favorites = productMapper.mapToProductList(result);
      return Result.success(favorites);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<bool, Exception>> addFavoriteProduct(String productId) async {
    try {
      bool result = await client.addFavoriteProduct(productId);
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<bool, Exception>> removeFavoriteProduct(
      String productId) async {
    try {
      bool result = await client.removeFavoriteProduct(productId);
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
}
