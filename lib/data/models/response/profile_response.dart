import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

import '../request/create_order_request.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class NetworkProfile {
  String firstName;
  String secondName;
  String mobileNumber;
  String? instagram;
  List<NetworkOrder> orders;
  String role;
  List<NetworkProduct> favoriteProducts;
  NetworkCity? city;
  NetworkNovaPost? novaPost;
  String password;
  String id;

  NetworkProfile({
    required this.favoriteProducts,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.instagram,
    required this.orders,
    required this.city,
    required this.novaPost,
    required this.role,
    required this.password,
    required this.id,
  });

  factory NetworkProfile.fromJson(Map<String, dynamic> json) =>
      _$NetworkProfileFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProfileToJson(this);
}
