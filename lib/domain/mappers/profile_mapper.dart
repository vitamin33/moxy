import 'package:moxy/data/models/response/profile_response.dart';
import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';

import '../../services/get_it.dart';
import '../models/profile.dart';

class ProfileMapper {
  final productMapper = locate<ProductMapper>();
  final orderMapper = locate<OrderMapper>();
  Profile mapToProfile(NetworkProfile networkProfile) {
    return Profile(
        favoriteProducts:
            productMapper.mapToProductList(networkProfile.favoriteProducts),
        firstName: networkProfile.firstName,
        secondName: networkProfile.secondName,
        mobileNumber: networkProfile.mobileNumber,
        orders: orderMapper.mapToOrderList(networkProfile.orders));
  }
}
