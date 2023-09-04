import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/product.dart';

class Profile {
  final List<Product> favoriteProducts;
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final List<Order> orders;

  Profile({
    required this.favoriteProducts,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.orders,
  });

  static Profile defaultProfile() {
    return Profile(
        favoriteProducts: [],
        firstName: '',
        secondName: '',
        mobileNumber: '',
        orders: [],
        );
  }

  Profile copyWith({
  List<Product>? favoriteProducts,
  String? firstName,
  String? secondName,
  String? mobileNumber,
  List<Order>? orders,
  }) {
    return Profile(
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      orders: orders ?? this.orders,
    );
  }
}