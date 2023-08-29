import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class NetworkProfile {
  List<NetworkProduct> favoriteProducts;
  String firstName;
  String secondName;
  String mobileNumber;
  List<NetworkOrder> orders;
  String role;
  String password;
  String id;
  

  NetworkProfile({
    required this.favoriteProducts,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.orders,
    required this.role,
    required this.password,
    required this.id,
  });

  factory NetworkProfile.fromJson(Map<String, dynamic> json) =>
      _$NetworkProfileFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProfileToJson(this);
}