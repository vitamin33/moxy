import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';

import '../copyable.dart';

class ProfileUser implements Copyable<ProfileUser> {
  String? id;
  String firstName;
  String secondName;
  String mobileNumber;
  City? city;
  Warehouse? novaPost;
  String? instagram;

  ProfileUser({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.novaPost,
    required this.instagram,
  });

  static ProfileUser defaultUser() {
    return ProfileUser(
      id: '',
      firstName: '',
      secondName: '',
      mobileNumber: '',
      city: City.defaultCity(),
      novaPost: Warehouse.defaultWarehouse(),
      instagram: '',
    );
  }

  @override
  ProfileUser copyWith({
    String? id,
    String? firstName,
    String? secondName,
    String? mobileNumber,
    City? city,
    Warehouse? novaPost,
    String? instagram,
  }) {
    return ProfileUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      city: city ?? this.city,
      novaPost: novaPost ?? this.novaPost,
      instagram: instagram ?? this.instagram,
    );
  }
}
