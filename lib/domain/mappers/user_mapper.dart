import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/services/get_it.dart';

import '../../data/models/request/user_request.dart';
import '../models/user.dart';

class UserMapper {
  final cityMapper = locate<CityMapper>();
  final warehouseMapper = locate<WarehouseMapper>();

  NetworkUser mapToNetworkUser(User user) {
    return NetworkUser(
      userId: user.id,
      firstName: user.firstName,
      secondName: user.secondName,
      mobileNumber: user.mobileNumber,
      city: user.city,
      instagram: user.instagram,
    );
  }

  NetworkProfileUser mapToNetworkProfileUser(
      User user, City? city, Warehouse? novaPost) {
    return NetworkProfileUser(
      userId: user.id,
      firstName: user.firstName,
      secondName: user.secondName,
      mobileNumber: user.mobileNumber,
      city: cityMapper.mapToNetworkCity(city),
      novaPost: warehouseMapper.mapToNetworkNovaPost(novaPost),
      instagram: user.instagram,
    );
  }

  User mapToUser(NetworkUser network) {
    return User(
      id: network.userId ?? '',
      firstName: network.firstName ?? '',
      secondName: network.secondName ?? '',
      mobileNumber: network.mobileNumber,
      city: network.city ?? '',
      instagram: network.instagram ?? '',
    );
  }

  NetworkPasswordUser maptoNetworkPassword(ProfilePassword password) {
    return NetworkPasswordUser(
        newPassword: password.newPassword, oldPassword: password.oldPassword);
  }
}
