import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/warehouse.dart';

import 'city.dart';

class Profile {
  final List<Product> favoriteProducts;
  final String id;
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final String? instagram;
  final City city;
  final Warehouse warehouse;

  Profile({
    required this.favoriteProducts,
    required this.firstName,
    required this.id,
    required this.secondName,
    required this.mobileNumber,
    required this.instagram,
    required this.city,
    required this.warehouse,
  });

  static Profile defaultProfile() {
    return Profile(
      favoriteProducts: [],
      id: '',
      firstName: '',
      secondName: '',
      mobileNumber: '',
      instagram: '',
      city: City.defaultCity(),
      warehouse: Warehouse.defaultWarehouse(),
    );
  }

  Profile copyWith({
    List<Product>? favoriteProducts,
    String? firstName,
    String? id,
    String? secondName,
    String? mobileNumber,
    String? instagram,
    City? city,
    Warehouse? warehouse,
  }) {
    return Profile(
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      instagram: instagram ?? this.instagram,
      city: city ?? this.city,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  bool isGuest() {
    return mobileNumber.isEmpty;
  }
}

class ProfilePassword {
  final String oldPassword;
  final String newPassword;
  final String repeatNewPassword;

  ProfilePassword({
    required this.oldPassword,
    required this.newPassword,
    required this.repeatNewPassword,
  });

  static ProfilePassword defaultProfilePassword() {
    return ProfilePassword(
      oldPassword: '',
      newPassword: '',
      repeatNewPassword: '',
    );
  }

  ProfilePassword copyWith({
    String? oldPassword,
    String? newPassword,
    String? repeatNewPassword,
  }) {
    return ProfilePassword(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      repeatNewPassword: repeatNewPassword ?? this.repeatNewPassword,
    );
  }
}
