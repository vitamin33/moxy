import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/domain/models/warehouse.dart';

import '../../data/models/request/user_request.dart';
import '../models/user.dart';

class UserMapper {
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
      User user, City city, Warehouse novaPost) {
    return NetworkProfileUser(
      userId: user.id,
      firstName: user.firstName,
      secondName: user.secondName,
      mobileNumber: user.mobileNumber,
      city: NetworkCity(
          mainDescription: city.mainDescription,
          ref: city.ref,
          deliveryCityRef: city.deliveryCityRef,
          presentName: city.presentName),
      novaPost: NetworkNovaPost(
          ref: novaPost.ref,
          presentName: novaPost.description,
          number: novaPost.number),
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
