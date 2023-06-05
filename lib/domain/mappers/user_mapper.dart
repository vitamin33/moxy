import '../../data/models/request/user_request.dart';
import '../models/user.dart';

class UserMapper {
  NetworkUser mapToNetworkUser(User user) {
    return NetworkUser(
      firstName: user.firstName,
      secondName: user.secondName,
      mobileNumber: user.mobileNumber,
      city: user.city,
      instagram: user.instagram,
    );
  }

  User mapToUser(NetworkUser network) {
    return User(
      firstName: network.firstName ?? '',
      secondName: network.secondName ?? '',
      mobileNumber: network.mobileNumber,
      city: network.city ?? '',
      instagram: network.instagram ?? '',
    );
  }
}
