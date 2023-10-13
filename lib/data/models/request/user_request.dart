import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moxy/data/models/request/create_order_request.dart';

part 'user_request.g.dart';

@JsonSerializable()
class NetworkUser {
  final String? userId;
  final String? firstName;
  final String? secondName;
  final String mobileNumber;
  final NetworkCity? city;
  final String? instagram;

  NetworkUser({
    required this.userId,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.instagram,
  });

  factory NetworkUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUserToJson(this);
}

@JsonSerializable()
class NetworkProfileUser {
  final String? userId;
  final String? firstName;
  final String? secondName;
  final String mobileNumber;
  final NetworkCity? city;
  final NetworkNovaPost? novaPost;
  final String? instagram;

  NetworkProfileUser({
    required this.userId,
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.novaPost,
    required this.instagram,
  });

  factory NetworkProfileUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkProfileUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkProfileUserToJson(this);
}

@JsonSerializable()
class NetworkPasswordUser {
  final String? oldPassword;
  final String? newPassword;

  NetworkPasswordUser({
    required this.oldPassword,
    required this.newPassword,
  });

  factory NetworkPasswordUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkPasswordUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkPasswordUserToJson(this);
}
