import '../../data/models/request/user_request.dart';
import '../models/user.dart';

class UserMapper {
  NetworkGuestUser mapToNetworkUser(User user) {
    return NetworkGuestUser(
      firstName: user.firstName,
      secondName: user.secondName,
      mobileNumber: user.mobileNumber,
      city: user.city,
      instagram: user.instagram,
    );
  }

  User mapToUser(NetworkGuestUser network) {
    return User(
      firstName: network.firstName,
      secondName: network.secondName,
      mobileNumber: network.mobileNumber,
      city: network.city,
      instagram: network.instagram,
    );
  }
}
