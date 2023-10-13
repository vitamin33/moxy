import 'package:moxy/domain/models/city.dart';

import '../copyable.dart';

class User implements Copyable<User> {
  String? id;
  String firstName;
  String secondName;
  String mobileNumber;
  City? city;
  String? instagram;

  User({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.instagram,
  });

  static User defaultUser() {
    return User(
      id: '',
      firstName: '',
      secondName: '',
      mobileNumber: '',
      city: City.defaultCity(),
      instagram: '',
    );
  }

  @override
  User copyWith({
    String? id,
    String? firstName,
    String? secondName,
    String? mobileNumber,
    City? city,
    String? instagram,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      city: city ?? this.city,
      instagram: instagram ?? this.instagram,
    );
  }
}
